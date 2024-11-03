import {getMessaging} from "firebase-admin/messaging";
import {getFirestore} from "firebase-admin/firestore";

const poolSize = 100;

export const sendTShirtNotification = async () => {
    try {const usersSnap = await getFirestore()
            .collection('users')
            .where('tShirtPickupRequested', '==', false)
            .where('tShirtPickup', '==', false)
            .where('isStaff', '==', false)
            .where('fcmToken', '!=', null)
            .get();

        const users = usersSnap.docs.sort(() => Math.random() - Math.random())
            .slice(0, poolSize).map(doc => {
                return {
                    fcmToken: doc.data().fcmToken,
                    id: doc.id,
                }
            });

        if (users.length === 0) {
            console.info('🚫 No users to send notifications to');
            return;
        }

        console.info('📩 Sending notifications to:', users.length, 'users');

        for (const user of users) {
            console.info('📲 Sending notification to: ', user.id, 'with token:', user.fcmToken);
            const message = {
                notification: {
                    title: 'Hey, it\'s time to pick up your t-shirt!',
                    body: 'Got to the gadget desk and ask to the staff for your t-shirt. Enjoy it!'
                },
                token: user.fcmToken
            };

            try {
                await getMessaging().send(message);

                await getFirestore().collection('users').doc(user.id).update({
                    tShirtPickupRequested: true
                });

                 console.info('✅  Notification sent to: ', user.id);
            } catch (error) {
                console.error('‼️ An error occurred when sending notification to: ', user.id, ':', error);
            }
        }

    } catch (parseError) {
        console.error('‼️ Error parsing the JSON data:', parseError);
    }
}
