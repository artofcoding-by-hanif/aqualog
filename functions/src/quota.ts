import { getFirestore, FieldValue } from "firebase-admin/firestore";
import { HttpsError } from "firebase-functions/v2/https";

import { utcDay } from "./validation.js";

/**
 * Daily per-user request limit, counted in Firestore at
 * `aiUsage/{uid}/days/{yyyy-mm-dd}`.
 *
 * Subscriptions will plug in here: premium users get the higher limit.
 */
function todayRef(uid: string) {
  return getFirestore()
    .collection("aiUsage")
    .doc(uid)
    .collection("days")
    .doc(utcDay(new Date()));
}

/** Take one request from today's allowance; returns how many are left */
export async function consumeQuota(
  uid: string,
  plan: { limit: number; premium: boolean },
): Promise<number> {
  const ref = todayRef(uid);
  const dailyLimit = plan.limit;

  return getFirestore().runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const used = (snap.get("count") as number | undefined) ?? 0;
    if (used >= dailyLimit) {
      throw new HttpsError(
        "resource-exhausted",
        plan.premium
          ? `You've reached today's limit of ${dailyLimit} AI requests. It resets at midnight UTC.`
          : `You've used today's ${dailyLimit} free AI requests. Upgrade to Premium for more, or try again tomorrow.`,
        { premium: plan.premium },
      );
    }
    tx.set(
      ref,
      { count: FieldValue.increment(1), updatedAt: FieldValue.serverTimestamp() },
      { merge: true },
    );
    return dailyLimit - used - 1;
  });
}

/** Give back a request that failed through no fault of the user */
export async function refundQuota(uid: string): Promise<void> {
  await todayRef(uid).set(
    { count: FieldValue.increment(-1), updatedAt: FieldValue.serverTimestamp() },
    { merge: true },
  );
}
