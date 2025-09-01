import {QuestTypeEnum} from "./quest-type-enum";
import {Answer} from "./answer";
import {QuestSubTypeEnum} from "./quest-sub-type-enum";
import {PromptFunctions} from "../prompt-functions";
import {LocalizedField} from "./localized-field";

export type Quest = {
  id: string;
  title: LocalizedField;
  description: LocalizedField;
  points: number[];
  validityStart: Date;
  validityEnd: Date;
  executionTime: number;
  type: QuestTypeEnum;
  subType: QuestSubTypeEnum | null;

  // Actor & community quest section
  queueTime: number | null;
  actor: string | null;
  maxQueue: number | null;
  groupSize: number | null;
  requestAccepted: boolean | null;
  promptFunction: PromptFunctions | null;

  // Quiz quest section
  parentQuests: string[] | null;
  qrCode: string | null;
  question: LocalizedField | null;
  answers: Answer[] | null;

  // Social quest section
  verificationFunction: string | null;
}
