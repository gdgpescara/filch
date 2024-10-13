import {exec} from "child_process";

export const deployFirebaseFunctions = async () => {
    try {
        console.info('🚀 Deploying Firebase functions...');
        await exec('firebase deploy --only functions');
        console.info('✅  Firebase functions deployed\n\n');
    } catch (error) {
        console.error('‼️ An error occurred:', error);
    }
}