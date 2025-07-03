import {Quest} from "./quest";
import {firestore} from "firebase-admin";
import {LocalizedField} from "./localized-field";
import Timestamp = firestore.Timestamp;

export type ActiveQuest = {
  quest: Quest;
  prompt: LocalizedField;
  activatedAt: Timestamp;
}
