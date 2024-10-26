import {LocalizedField} from "./localized-field";

export type Answer = {
  id: number;
  text: LocalizedField;
  isCorrect: boolean;
}
