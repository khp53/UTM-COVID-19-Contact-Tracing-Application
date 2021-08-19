const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp(functions.config().functions);

const db = admin.firestore();
const fcm = admin.messaging();

exports.sendExposureNotification = functions.firestore.document('HealthStatus/{userId}').onUpdate(async snapshot => {
    var tokens = [];
    //const user = snapshot.data();
    const oldSnap = snapshot.before.data();
    const newSnap = snapshot.after.data();

    if (oldSnap.covidStatus == false && newSnap.covidStatus == true){

        const querySnapshot = await db.collection('TraceContacts').doc(newSnap.regID).collection('contactedWith').get();
        for (var token of querySnapshot.docs) {
            tokens.push(token.data().deviceToken);
        }

        const payload = {
            notification: {
            android_channel_id: "high_importance_channel",
            title: 'Contact Exposure Alert!',
            body: 'One of your contacts has been tested positive for COVID-19!',
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
            priority: "high",
            }
        };
    
        try {
            const response = await fcm.sendToDevice(tokens, payload);
            console.log('Notification sent successfully');
        } catch (err) {
            console.log(err);
        }
    }
});
