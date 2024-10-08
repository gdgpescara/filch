import {firestore} from "firebase-admin";
import {PointsTypeEnum} from "./points-type-enum";
import Timestamp = firestore.Timestamp;

export type Points = {
  assignedBy: string | null;
  assignedFrom: string | null;
  type: PointsTypeEnum;
  points: number;
  assignedAt: Timestamp;
  quest: string | null;
}
