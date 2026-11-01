import assert from "node:assert/strict";
import { test } from "node:test";

import { InvalidInput, LIMITS, parseAnalyzeRequest, parseChatRequest, utcDay } from "./validation.js";

test("accepts a valid chat request and trims text", () => {
  const parsed = parseChatRequest({
    tankContext: { tank: { name: "Betta tank" } },
    messages: [{ role: "user", text: "  Why is my water cloudy?  " }],
  });
  assert.equal(parsed.messages[0].text, "Why is my water cloudy?");
  assert.deepEqual(parsed.tankContext, { tank: { name: "Betta tank" } });
});

test("keeps only the most recent messages", () => {
  const messages = Array.from({ length: 31 }, (_, i) => ({
    role: i % 2 === 0 ? "user" : "model",
    text: `message ${i}`,
  }));
  const parsed = parseChatRequest({ messages });
  assert.equal(parsed.messages.length, LIMITS.historyMessages);
  assert.equal(parsed.messages.at(-1)?.text, "message 30");
});

test("rejects bad chat requests", () => {
  const bad: unknown[] = [
    null,
    { messages: [] },
    { messages: [{ role: "system", text: "hi" }] },
    { messages: [{ role: "user", text: "   " }] },
    { messages: [{ role: "user", text: "x".repeat(LIMITS.messageChars + 1) }] },
    { messages: [{ role: "user", text: "q" }, { role: "model", text: "a" }] },
    { messages: [{ role: "user", text: "q" }], tankContext: "not an object" },
  ];
  for (const data of bad) {
    assert.throws(() => parseChatRequest(data), InvalidInput, JSON.stringify(data));
  }
});

test("analyze requires a reasonably sized context", () => {
  assert.throws(() => parseAnalyzeRequest({}), InvalidInput);
  assert.throws(
    () => parseAnalyzeRequest({ tankContext: { blob: "x".repeat(LIMITS.contextChars) } }),
    InvalidInput,
  );
  assert.ok(parseAnalyzeRequest({ tankContext: { tank: {} } }).tankContext);
});

test("quota buckets by UTC day", () => {
  assert.equal(utcDay(new Date("2026-11-01T23:59:59Z")), "2026-11-01");
});
