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
  /** Characters of AI output attached to a report */
  reportContentChars: 12_000,
  /** Characters in the reporter's optional note */
  reportNoteChars: 500,
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

export const REPORT_REASONS = ["harmful", "offensive", "inaccurate", "other"] as const;
export type ReportReason = (typeof REPORT_REASONS)[number];

export interface ReportRequest {
  kind: "chat" | "health";
  reason: ReportReason;
  content: string;
  note: string | null;
}

/** A user's report of AI output they found harmful, offensive or wrong */
export function parseReportRequest(data: unknown): ReportRequest {
  if (!isPlainObject(data)) throw new InvalidInput("Request must be an object.");
  const { kind, reason, content, note } = data;
  if (kind !== "chat" && kind !== "health") {
    throw new InvalidInput('kind must be "chat" or "health".');
  }
  if (typeof reason !== "string" || !(REPORT_REASONS as readonly string[]).includes(reason)) {
    throw new InvalidInput(`reason must be one of ${REPORT_REASONS.join(", ")}.`);
  }
  if (typeof content !== "string" || content.trim().length === 0) {
    throw new InvalidInput("content is required.");
  }
  if (note !== undefined && note !== null && typeof note !== "string") {
    throw new InvalidInput("note must be a string.");
  }
  return {
    kind,
    reason: reason as ReportReason,
    content: content.trim().slice(0, LIMITS.reportContentChars),
    note: typeof note === "string" && note.trim() ? note.trim().slice(0, LIMITS.reportNoteChars) : null,
  };
}
