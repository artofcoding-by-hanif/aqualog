import { initializeApp } from "firebase-admin/app";
import { setGlobalOptions } from "firebase-functions/v2";
import { CallableRequest, HttpsError, onCall } from "firebase-functions/v2/https";
import { defineInt, defineSecret, defineString } from "firebase-functions/params";
import { logger } from "firebase-functions";
import { GenerateContentConfig, GoogleGenAI, ThinkingLevel } from "@google/genai";

import { AttemptInfo, generateWithRetry, IncompleteResponse, ModelsBusy } from "./gemini.js";
import { ANALYSIS_SCHEMA, ANALYZE_SYSTEM_PROMPT, CHAT_SYSTEM_PROMPT, withTankData } from "./prompts.js";
import { hasPremium } from "./entitlement.js";
import { consumeQuota, refundQuota } from "./quota.js";
import { InvalidInput, parseAnalyzeRequest, parseChatRequest } from "./validation.js";

initializeApp();
setGlobalOptions({ region: "us-central1", maxInstances: 10 });

/** Set with: firebase functions:secrets:set GEMINI_API_KEY */
const geminiApiKey = defineSecret("GEMINI_API_KEY");

/** Model id; the alias tracks Google's current Flash model */
const geminiModel = defineString("GEMINI_MODEL", { default: "gemini-flash-latest" });

/** Used when the main model is overloaded */
const geminiFallbackModel = defineString("GEMINI_FALLBACK_MODEL", {
  default: "gemini-flash-lite-latest",
});

/** AI requests per user per day, by plan */
const freeDailyLimit = defineInt("AI_FREE_DAILY_LIMIT", { default: 3 });
const premiumDailyLimit = defineInt("AI_PREMIUM_DAILY_LIMIT", { default: 100 });

/**
 * RevenueCat secret API key, used to check the Premium entitlement.
 * Set with: firebase functions:secrets:set REVENUECAT_SECRET_KEY
 * (enter "none" until RevenueCat is set up; everyone is then on the free plan)
 */
const revenueCatSecretKey = defineSecret("REVENUECAT_SECRET_KEY");
const ENTITLEMENT_ID = "premium";

const callableOptions = {
  secrets: [geminiApiKey, revenueCatSecretKey],
  // Only genuine app builds (or registered debug tokens) may call these
  enforceAppCheck: true,
  // Callables must be publicly invokable at the Cloud Run level; access is
  // controlled by App Check and Firebase Auth inside the function instead
  invoker: "public" as const,
  timeoutSeconds: 120,
  memory: "512MiB" as const,
};

/** Retries stop starting well before the function timeout */
const MODEL_BUDGET_MS = 95_000;

/** One slow call shouldn't eat the whole budget; the fallback gets its turn */
const ATTEMPT_TIMEOUT_MS = 20_000;

function logAttempt(fn: string, uid: string) {
  return (info: AttemptInfo) => logger.info(`${fn} gemini attempt`, { uid, ...info });
}

/** Low thinking keeps answers fast; output allowance covers thoughts + reply */
const BASE_CONFIG: GenerateContentConfig = {
  thinkingConfig: { thinkingLevel: ThinkingLevel.LOW },
  maxOutputTokens: 8192,
};

function requireUser(request: CallableRequest): string {
  const uid = request.auth?.uid;
  if (!uid) throw new HttpsError("unauthenticated", "Sign-in required.");
  return uid;
}

function models() {
  return new GoogleGenAI({ apiKey: geminiApiKey.value() }).models;
}

function modelList(): string[] {
  return [geminiModel.value(), geminiFallbackModel.value()].filter(
    (m, i, all) => m && all.indexOf(m) === i,
  );
}

/** The user's plan limit; falls back to the free limit if the lookup fails */
async function dailyLimitFor(uid: string): Promise<{ limit: number; premium: boolean }> {
  try {
    const premium = await hasPremium(uid, {
      secretKey: revenueCatSecretKey.value(),
      entitlementId: ENTITLEMENT_ID,
    });
    return { limit: premium ? premiumDailyLimit.value() : freeDailyLimit.value(), premium };
  } catch (error) {
    logger.warn("Premium lookup failed; applying free limit", { uid, error: String(error) });
    return { limit: freeDailyLimit.value(), premium: false };
  }
}

/**
 * Runs one quota-counted request: takes a unit of quota, refunds it if the
 * request fails, and turns failures into callable errors.
 */
async function metered<T>(
  name: string,
  uid: string,
  run: () => Promise<T>,
): Promise<T & { remaining: number }> {
  let charged = false;
  try {
    const remaining = await consumeQuota(uid, await dailyLimitFor(uid));
    charged = true;
    return { ...(await run()), remaining };
  } catch (error) {
    if (charged) await refundQuota(uid).catch(() => undefined);
    if (error instanceof HttpsError) throw error;
    if (error instanceof InvalidInput) throw new HttpsError("invalid-argument", error.message);
    logger.error(`${name} failed`, { uid, error: String(error) });
    if (error instanceof ModelsBusy) {
      throw new HttpsError("unavailable", "The assistant is very busy right now. Please try again in a minute.");
    }
    if (error instanceof IncompleteResponse) {
      throw new HttpsError("unavailable", "The assistant couldn't finish its answer. Please try again.");
    }
    throw new HttpsError("unavailable", "The assistant is unavailable right now. Please try again.");
  }
}

/**
 * Chat with the assistant about a tank.
 *
 * Request:  { tankContext?: object, messages: [{ role: "user"|"model", text }] }
 * Response: { reply: string, remaining: number }
 */
export const aiChat = onCall(callableOptions, async (request) => {
  const uid = requireUser(request);
  const { tankContext, messages } = (() => {
    try {
      return parseChatRequest(request.data);
    } catch (error) {
      if (error instanceof InvalidInput) throw new HttpsError("invalid-argument", error.message);
      throw error;
    }
  })();

  return metered("aiChat", uid, async () => {
    const response = await generateWithRetry(models(), {
      models: modelList(),
      contents: messages.map((m) => ({ role: m.role, parts: [{ text: m.text }] })),
      config: {
        ...BASE_CONFIG,
        systemInstruction: `${CHAT_SYSTEM_PROMPT}\n\n${withTankData(tankContext)}`,
        temperature: 0.6,
      },
      budgetMs: MODEL_BUDGET_MS,
      attemptTimeoutMs: ATTEMPT_TIMEOUT_MS,
      onAttempt: logAttempt("aiChat", uid),
    });

    const reply = response.text?.trim();
    if (!reply) throw new IncompleteResponse("Empty response from model");
    return { reply };
  });
});

/**
 * Structured health check and action plan for a tank.
 *
 * Request:  { tankContext: object }
 * Response: { analysis: <ANALYSIS_SCHEMA>, remaining: number }
 */
export const analyzeTank = onCall(callableOptions, async (request) => {
  const uid = requireUser(request);
  const { tankContext } = (() => {
    try {
      return parseAnalyzeRequest(request.data);
    } catch (error) {
      if (error instanceof InvalidInput) throw new HttpsError("invalid-argument", error.message);
      throw error;
    }
  })();

  return metered("analyzeTank", uid, async () => {
    const response = await generateWithRetry(models(), {
      models: modelList(),
      contents: [
        {
          role: "user",
          parts: [{ text: `Analyze this tank.\n\n${withTankData(tankContext)}` }],
        },
      ],
      config: {
        ...BASE_CONFIG,
        systemInstruction: ANALYZE_SYSTEM_PROMPT,
        temperature: 0.3,
        responseMimeType: "application/json",
        responseJsonSchema: ANALYSIS_SCHEMA,
      },
      budgetMs: MODEL_BUDGET_MS,
      attemptTimeoutMs: ATTEMPT_TIMEOUT_MS,
      onAttempt: logAttempt("analyzeTank", uid),
    });

    const text = response.text;
    if (!text) throw new IncompleteResponse("Empty response from model");
    try {
      return { analysis: JSON.parse(text) };
    } catch {
      throw new IncompleteResponse("Model returned invalid JSON");
    }
  });
});
