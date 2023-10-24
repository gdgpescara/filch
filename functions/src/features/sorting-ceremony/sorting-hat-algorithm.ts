import {firestore} from "firebase-admin";
import {HttpsError} from "firebase-functions/v2/https";
import QueryDocumentSnapshot = firestore.QueryDocumentSnapshot;

export const sortingHatAlgorithm = (items: QueryDocumentSnapshot[]) => {
  const sum = items.reduce((acc, item) => acc + item.data()["members"], 0);
  const weights = items.map((item) => sum - item.data()["members"]);
  const cumulativeWeights = weights.reduce(
    (acc: number[], weight) => [...acc, weight + (acc[acc.length - 1] || 0)],
    [],
  );
  const max = cumulativeWeights[cumulativeWeights.length - 1];
  const random = Math.random() * max;

  let item: QueryDocumentSnapshot | undefined;
  for (let i = 0; i < items.length; i++) {
    if (cumulativeWeights[i] >= random) {
      return item = items[i];
    }
  }

  if (!item) throw new HttpsError("internal", "No house found");
  return item;
};
