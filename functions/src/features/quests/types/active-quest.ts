import {Quest} from "./quest";
import {firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;

export type ActiveQuest = {
  quest: Quest;
  activatedAt: Timestamp;
}
