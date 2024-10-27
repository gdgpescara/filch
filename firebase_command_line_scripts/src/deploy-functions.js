import {exec} from "child_process";

export const deployFirebaseFunctions = async () => {
    try {
        console.info('🚀 Deploying Firebase functions...');
        await exec('firebase deploy --only functions', (error, stdout, stderr) => {
            if (error) {
                console.error(`‼️ An error occurred: ${error.message}`);
                return;
            }
            if (stderr) {
                console.error(`‼️ An error occurred: ${stderr}`);
                return;
            }
            console.info(`✅  Firebase functions deployed: ${stdout}\n\n`);
        });
    } catch (error) {
        console.error('‼️ An error occurred:', error);
    }
}