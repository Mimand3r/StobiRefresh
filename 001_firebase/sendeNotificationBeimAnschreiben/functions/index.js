const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendeNotificationsBeimAnschreiben = functions.firestore
    .document('messages/{groupId1}/{groupId2}/{message}')
    .onCreate(async (snap, context) => {

        const message = snap.data();
        console.log("New Message arrived");
        console.log(message);
        
        const convId = context.params.groupId1;
        const idSender = message.idFrom; 
        const idReceiver = message.idTo; 
        const messageContent = message.content;

        // Check if Receiver is in Chat with sender
        let receiverSnap = await admin.firestore().collection('users').doc(idReceiver).get();
        if (receiverSnap.empty) return;
        let receiverData = receiverSnap.data();
        console.log(receiverData);
        if (receiverData.pushToken === undefined || receiverData.pushToken === '') return;
        if (receiverData.isInChat === convId){
            console.log("Sender und receiver sind im selben Chat. Keine Message versandt");
            return;
        }
        
        console.log('Empfänger ist nicht im Chat. Er wird benachrichtigt');

        let unreadMessagesOld = receiverData.unreadMessages;
        let unreadCount = 0;
        if (unreadMessagesOld[convId] !== undefined) unreadCount = unreadMessagesOld[convId];
        // Update receivers UnreadMessages Field


        let unreadMessages = unreadMessagesOld;
        unreadMessages[convId] = unreadCount + 1;
        await admin.firestore().collection('users').doc(idReceiver).update({
            'unreadMessages':unreadMessages
        });

        // Create Notification
        const notification = {
            notification: {
                title: `Du wurdest angeschrieben`,
                body: messageContent,
                badge: '1',
                sound: 'default'
            }
        };
        
        // Versende
        let response = await admin.messaging().sendToDevice(receiverData.pushToken, notification);
        console.log("Nachricht erfolgreich versandt:", response);

});
