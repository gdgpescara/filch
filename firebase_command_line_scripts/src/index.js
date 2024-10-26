import {initConfigurations} from './init-configurations.js';
import {createAccounts} from "./create-users.js";
import Enquirer from 'enquirer';
import {updateQuests} from "./update-quests.js";
import {deployFirebaseFunctions} from "./deploy-functions.js";

const steps = [
    {
        name: 'init-configurations',
        message: 'Initialize configurations',
        value: initConfigurations
    },
    {
        name: 'create-users',
        message: 'Create users',
        value: createAccounts
    },
    {
        name: 'upload-quests',
        message: 'Upload quests',
        value: updateQuests
    },
    {
        name: 'deploy-functions',
        message: 'Deploy functions',
        value: deployFirebaseFunctions
    }
];

const prompt = new Enquirer.prompts.MultiSelect({
    name: 'steps',
    message: 'Select what steps you want to run:',
    choices: [
        {
            name: 'all',
            message: 'Run all steps',
            value: undefined
        },
        ...steps
    ]
});

prompt.run()
    .then(answer => {
        const selectedSteps = (answer.includes('all') ? steps : steps.filter(step => answer.includes(step.name))).map(step => step.value);
        const runStep = async (step) => {
            console.info(`🚀 Running step: ${step.name}...`);
            await step();
            console.info(`🎉 Done with step: ${step.name}!\n\n`);
        };
        selectedSteps.reduce((promise, step) => promise.then(() => runStep(step)), Promise.resolve());
    })
    .catch((error) => {
        if(error) {
            console.error('‼️ An error occurred:', error);
        }
    });