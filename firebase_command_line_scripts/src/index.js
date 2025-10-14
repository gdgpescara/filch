import { initConfigurations } from "./init-configurations.js";
import Enquirer from "enquirer";
import { updateQuests } from "./update-quests.js";
import { deployFirebaseFunctions } from "./deploy-functions.js";
import { sendTShirtNotification } from "./send-t-shirt-notification.js";
import { syncSessionizeData } from "./sync-sessionize.js";
import { registerStaffUser } from "./register-staff-user.js";

const steps = [
  {
    name: "init-configurations",
    message: "Initialize configurations",
    value: initConfigurations,
  },
  {
    name: "register-staff-user",
    message: "Register staff user",
    value: registerStaffUser,
  },
  {
    name: "register-sponsor-user",
    message: "Register sponsor user",
    value: registerSponsorUser,
  },
  {
    name: "upload-quests",
    message: "Upload quests",
    value: updateQuests,
  },
  {
    name: "send-t-shirt-notification",
    message: "Send t-shirt notification",
    value: sendTShirtNotification,
  },
  {
    name: "sync-sessionize",
    message: "Sync Sessionize data",
    value: syncSessionizeData,
  },
  {
    name: "deploy-functions",
    message: "Deploy functions",
    value: deployFirebaseFunctions,
  },
];

const prompt = new Enquirer.prompts.MultiSelect({
  name: "steps",
  message: "Select what steps you want to run:",
  choices: [
    {
      name: "all",
      message: "Run all steps",
      value: undefined,
    },
    ...steps,
  ],
});

prompt
  .run()
  .then(async (answer) => {
    const selectedSteps = (
      answer.includes("all")
        ? steps
        : steps.filter((step) => answer.includes(step.name))
    ).map((step) => step.value);
    const runStep = async (step) => {
      console.info(`🚀 Running step: ${step.name}...`);
      await step();
      console.info(`🎉 Done with step: ${step.name}!\n\n`);
    };
    await selectedSteps.reduce(
      (promise, step) => promise.then(() => runStep(step)),
      Promise.resolve()
    );
  })
  .catch((error) => {
    if (error) {
      console.error("‼️ An error occurred:", error);
    }
  });
