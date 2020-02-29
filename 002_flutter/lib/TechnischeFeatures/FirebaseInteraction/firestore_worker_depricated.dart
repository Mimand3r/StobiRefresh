import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data/database_types_depricated.dart';

class FirestoreWorker_depricated {
  static Future<void> writeUserToDb(DbUser_depricated user) async {
    await Firestore.instance
        .collection("users")
        .document(user.uId)
        .setData(user.toSnapshot());
  }

  static Future<DbUser_depricated> readUserFromDb(String uId) async {
    var snap = await Firestore.instance.collection("users").document(uId).get();

    if (snap.data == null) return null;

    return DbUser_depricated.fromSnapshot(snap);
  }

  static Stream<DocumentSnapshot> getUserStream(String uId) {
    return Firestore.instance.collection("users").document(uId).snapshots();
  }

  static Future<void> clearUnreadForConversation(
      DbUser_depricated user, String convId) async {
    user.unreadMessages.remove(convId);

    await Firestore.instance
        .collection("users")
        .document(user.uId)
        .updateData({'unreadMessages': user.unreadMessages});
  }

  static Future<void> registerBikeInUserData(String uId, Bike bike) async {
    await Firestore.instance.collection('users').document(uId).updateData({
      'registeredBikes': FieldValue.arrayUnion(<String>[bike.gestellNr])
    });
  }

  static Future<void> addConversationInUserData(
      String uId, Conversation conversation) async {
    await Firestore.instance.collection('users').document(uId).updateData({
      'conversations': FieldValue.arrayUnion(<String>[conversation.convId])
    });
  }

  static Future<void> setUserIsInChat(String uId, String chatId) async {
    await Firestore.instance
        .collection('users')
        .document(uId)
        .updateData({'isInChat': chatId});
  }

  static Future<void> storeUserMessageToken(String uId, String token) async {
    await Firestore.instance
        .collection('users')
        .document(uId)
        .updateData({'pushToken': token});
  }

  // Conversation Db

  static Future<Conversation> readConversationFromDb(String convId) async {
    var snap = await Firestore.instance
        .collection('conversations')
        .document(convId)
        .get();

    if (snap.data == null) return null;

    return Conversation.fromSnapshot(snap);
  }

  static Future<void> writeConversationToDb(Conversation conversation) async {
    await Firestore.instance
        .collection('conversations')
        .document(conversation.convId)
        .setData(conversation.toSnapshot());
  }

  static Future<List<DocumentSnapshot>> getAllConversationDocumentsForUser(
      DbUser_depricated user) async {
    var output = List<DocumentSnapshot>();

    if (user.conversations == null) return output;

    for (var i = 0; i < user.conversations.length; i++) {
      var ref = Firestore.instance
          .collection("conversations")
          .where("convId", isEqualTo: user.conversations[i]);
      var documents = await ref.getDocuments();
      output.add(documents.documents.first);
    }

    return output;
  }

  static Future<void> updateConversationLastMessage(
      String convId, String timestamp) async {
    await Firestore.instance
        .collection("conversations")
        .document(convId)
        .updateData({'lastMessage': timestamp});
  }

  // Bike

  static Future<void> writeBikeToDb(Bike bike) async {
    await Firestore.instance
        .collection('bikes')
        .document(bike.gestellNr)
        .setData(bike.toSnapshot());
  }

  static Future<Bike> readBikeFromDb(String gestellNr) async {
    var snap =
        await Firestore.instance.collection('bikes').document(gestellNr).get();

    if (snap.data == null) return null;

    return Bike.fromSnapshot(snap);
  }

  static Future<List<DocumentSnapshot>> getAllBikeDocumentsForUser(
      DbUser_depricated user) async {
    var ref = Firestore.instance.collection("bikes").where("besitzer",
        isEqualTo: user
            .uId); // Ist es besser das so zu machen und nicht die userbikeList zu benutzen?

    var documents = await ref.getDocuments();
    return documents.documents;
  }

  // Messages

  static Future<void> writeMessageTransactionToDb(
      Message message, String convId) async {
    var documentReference = Firestore.instance
        .collection('messages')
        .document(convId)
        .collection(convId)
        .document(message.timestamp);

    await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toSnapshot(),
      );
    });
  }

  static Stream<QuerySnapshot> getMessageStream(String convId,
      {int limitTo = 20}) {
    return Firestore.instance
        .collection('messages')
        .document(convId)
        .collection(convId)
        .orderBy('timestamp', descending: true)
        .limit(limitTo)
        .snapshots();
  }
}
