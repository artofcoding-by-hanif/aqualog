import { initializeApp } from "firebase-admin/app";
import { setGlobalOptions } from "firebase-functions/v2";
import { CallableRequest, HttpsError, onCall } from "firebase-functions/v2/https";
import { defineBoolean, defineInt, defineSecret, defineString } from "firebase-functions/params";
import { logger } from "firebase-functions";
import { GoogleGenAI } from "@google/genai";

import { ANALYSIS_SCHEMA, ANALYZE_SYSTEM_PROMPT, CHAT_SYSTEM_PROMPT, withTankData } from "./prompts.js";
import { consumeQuota } from "./quota.js";
import { InvalidInput, parseAnalyzeRequest, parseChatRequest } from "./validation.js";

initializeApp();
setGlobalOptions({ region: "us-central1", maxInstances: 10 });

/** Set with: firebase functions:secrets:set GEMINI_API_KEY */
const geminiApiKey = defineSecret("GEMINI_API_KEY");

/** Model id; the alias tracks Google's current Flash model */
const geminiModel = defineString("GEMINI_MODEL", { default: "gemini-flash-latest" });

/** Requests per user per day */
const dailyLimit = defineInt("AI_DAILY_LIMIT", { default: 30 });

/** Reject calls without a valid App Check token (keep true in production) */
const enforceAppCheck = defineBoolean("ENFORCE_APP_CHECK", { default: true });

const callableOptions = {
  secrets: [geminiApiKey],
  enforceAppCheck,
  timeoutSeconds: 60,
  memory: "512MiB" as const,
};

function requireUser(request: CallableRequest): string {
  const uid = request.auth?.uid;
  if (!uid) throw new HttpsError("unauthenticated", "Sign-in required.");
  return uid;
}

function client(): GoogleGenAI {
  return new GoogleGenAI({ apiKey: geminiApiKey.value() });
}

/** Turn validation and upstream failures into callable errors */
async function guarded<T>(name: string, uid: string, run: () => Promise<T>): Promise<T> {
  try {
    return await run();
  } catch (error) {
    if (error instanceof HttpsError) throw error;
    if (error instanceof InvalidInput) throw new HttpsError("invalid-argument", error.message);
    logger.error(`${name} failed`, { uid, error: String(error) });
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
  return guarded("aiChat", uid, async () => {
    const { tankContext, messages } = parseChatRequest(request.data);
    const remaining = await consumeQuota(uid, dailyLimit.value());

    const response = await client().models.generateContent({
      model: geminiModel.value(),
      contents: messages.map((m) => ({ role: m.role, parts: [{ text: m.text }] })),
      config: {
        systemInstruction: `${CHAT_SYSTEM_PROMPT}\n\n${withTankData(tankContext)}`,
        temperature: 0.6,
        maxOutputTokens: 1024,
      },
    });

    const reply = response.text?.trim();
    if (!reply) throw new Error("Empty response from model");
    return { reply, remaining };
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
  return guarded("analyzeTank", uid, async () => {
    const { tankContext } = parseAnalyzeRequest(request.data);
    const remaining = await consumeQuota(uid, dailyLimit.value());

    const response = await client().models.generateContent({
      model: geminiModel.value(),
      contents: [
        {
          role: "user",
          parts: [{ text: `Analyze this tank.\n\n${withTankData(tankContext)}` }],
        },
      ],
      config: {
        systemInstruction: ANALYZE_SYSTEM_PROMPT,
        temperature: 0.3,
        maxOutputTokens: 2048,
        responseMimeType: "application/json",
        responseJsonSchema: ANALYSIS_SCHEMA,
      },
    });

    const text = response.text;
    if (!text) throw new Error("Empty response from model");
    return { analysis: JSON.parse(text), remaining };
  });
});
