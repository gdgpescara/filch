import {getFirestore} from "firebase-admin/firestore";
import {logger} from "firebase-functions/v2";
import {LocalizedField} from "./types/localized-field";

const loveWords = async (): Promise<LocalizedField> => {
  const config = await getFirestore()
    .collection("configurations")
    .doc("prompts")
    .get();

  logger.info("prompts found: " + JSON.stringify(config.data()));

  const loveWords = config.data()?.loveWords ?? [];

  const pickedWords = loveWords
    .sort(() => Math.random() - Math.random())
    .slice(0, 5);

  const firstWord = pickedWords[0];
  const restWords = pickedWords.slice(1, 5);

  return restWords.reduce((acc: LocalizedField, word: LocalizedField) => {
    Object.keys(word).forEach((key) => {
      acc[key] = acc[key] + "\n" + word[key];
    });
    return acc;
  }, firstWord);
};


export enum PromptFunctions {
  loveWords = "loveWords",
}

export const promptFunctionsList = {
  [PromptFunctions.loveWords]: loveWords,
};
