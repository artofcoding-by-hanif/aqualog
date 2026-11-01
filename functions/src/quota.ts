import { getFirestore, FieldValue } from "firebase-admin/firestore";
import { HttpsError } from "firebase-functions/v2/https";

import { utcDay } from "./validation.js";

/**
 * Daily per-user request limit, counted in Firestore at
 * `aiUsage/{uid}/days/{yyyy-mm-dd}`.
 *
 * Subscriptions will plug in here: premium users get the higher limit.
 */
export async function consumeQuota(uid: string, dailyLimit: number): Promise<number> {
  const ref = getFirestore()
    .collection("aiUsage")
    .doc(uid)
    .collection("days")
    .doc(utcDay(new Date()));

  return getFirestore().runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const used = (snap.get("count") as number | undefined) ?? 0;
    if (used >= dailyLimit) {
      throw new HttpsError(
        "resource-exhausted",
        `Daily AI limit of ${dailyLimit} requests reached. It resets at midnight UTC.`,
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
