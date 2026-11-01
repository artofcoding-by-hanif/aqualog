/**
 * Input validation for the callable functions. Pure functions, no Firebase
 * imports, so they can be unit tested directly.
 */

export const LIMITS = {
  /** Serialized tank context, in characters */
  contextChars: 24_000,
  /** Messages kept from a chat history (oldest are dropped) */
  historyMessages: 20,
  /** Characters in one chat message */
  messageChars: 4_000,
} as const;

export class InvalidInput extends Error {}

export type ChatRole = "user" | "model";

export interface ChatMessage {
  role: ChatRole;
  text: string;
}

export interface ChatRequest {
  tankContext: Record<string, unknown> | null;
  messages: ChatMessage[];
}

export interface AnalyzeRequest {
  tankContext: Record<string, unknown>;
}

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function parseContext(value: unknown, required: boolean) {
  if (value === undefined || value === null) {
    if (required) throw new InvalidInput("tankContext is required.");
    return null;
  }
  if (!isPlainObject(value)) {
    throw new InvalidInput("tankContext must be an object.");
  }
  if (JSON.stringify(value).length > LIMITS.contextChars) {
    throw new InvalidInput("tankContext is too large.");
  }
  return value;
}

export function parseChatRequest(data: unknown): ChatRequest {
  if (!isPlainObject(data)) throw new InvalidInput("Request must be an object.");

  const rawMessages = data.messages;
  if (!Array.isArray(rawMessages) || rawMessages.length === 0) {
    throw new InvalidInput("messages must be a non-empty array.");
  }

  const messages = rawMessages.slice(-LIMITS.historyMessages).map((m, i) => {
    if (!isPlainObject(m)) throw new InvalidInput(`messages[${i}] is invalid.`);
    if (m.role !== "user" && m.role !== "model") {
      throw new InvalidInput(`messages[${i}].role must be "user" or "model".`);
    }
    if (typeof m.text !== "string" || m.text.trim().length === 0) {
      throw new InvalidInput(`messages[${i}].text must be a non-empty string.`);
    }
    if (m.text.length > LIMITS.messageChars) {
      throw new InvalidInput(`messages[${i}].text is too long.`);
    }
    return { role: m.role, text: m.text.trim() } as ChatMessage;
  });

  if (messages[messages.length - 1].role !== "user") {
    throw new InvalidInput("The last message must be from the user.");
  }

  return { tankContext: parseContext(data.tankContext, false), messages };
}

export function parseAnalyzeRequest(data: unknown): AnalyzeRequest {
  if (!isPlainObject(data)) throw new InvalidInput("Request must be an object.");
  return { tankContext: parseContext(data.tankContext, true)! };
}

/** Calendar day in UTC, used as the quota bucket */
export function utcDay(now: Date): string {
  return now.toISOString().slice(0, 10);
}
