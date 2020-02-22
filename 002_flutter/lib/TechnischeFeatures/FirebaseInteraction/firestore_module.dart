import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types.dart';

import 'firestore_worker.dart';

class FirestoreModule {
  // Singleton
  FirestoreModule._privateConstructor();
  static final FirestoreModule instance = FirestoreModule._privateConstructor();

  Future<DbUser> createNewUser(String uId, String name) async {
    var dbUser = DbUser(uId: uId, name: name);
    await FirestoreWorker.writeUserToDb(dbUser);

    return dbUser;
  }

  StreamSubscription<DocumentSnapshot> listenToUserChanges(
      DbUser user, void Function(DbUser) userGotChangedCallback) {
    var userSubscription = FirestoreWorker.getUserStream(user.uId).listen((s) {
      var newUser = DbUser.fromSnapshot(s);
      userGotChangedCallback(newUser);
    });

    return userSubscription;
  }

  Future<Bike> registerABike(DbUser owner, String gestellNr, String modell,
      String spitzName, String picUrl) async {
    // Check if Bike already Exists
    var oldBike = await FirestoreWorker.readBikeFromDb(gestellNr);
    if (oldBike != null) throw Exception("Bike was already registered");

    var bike = Bike(
        gestellNr: gestellNr,
        besitzer: owner.uId,
        modell: modell,
        spitzName: spitzName,
        picUrl: picUrl);

    var writeBikeDb = FirestoreWorker.writeBikeToDb(bike);
    var writeUserDb = FirestoreWorker.registerBikeInUserData(owner.uId, bike);

    await writeBikeDb;
    await writeUserDb;

    return bike;
  }

  Future<Bike> searchABike(String gestellNr) async {
    var bike = await FirestoreWorker.readBikeFromDb(gestellNr);

    return bike;
  }

  Future<Conversation> erstelleNeueKonversationMitFahrradBesitzer(
      DbUser user, Bike fahrrad) async {
    // Create a ConvId
    var uId = user.uId;
    var u2Id = fahrrad.besitzer;
    var convId = (uId.hashCode >= u2Id.hashCode) ? '$uId-$u2Id' : '$u2Id-$uId';

    // Check if Conversation already Exists
    var existingConv = await FirestoreWorker.readConversationFromDb(convId);
    if (existingConv != null) return existingConv;

    // Make Conversation Entry
    var newConv = Conversation(
        convId: convId,
        ersteller: uId,
        adressant: u2Id,
        fahrradGestellNr: fahrrad.gestellNr,
        fahrradModell: fahrrad.modell,
        fahrradUrl: fahrrad.picUrl,
        lastMessage: 0);

    var convWrite = FirestoreWorker.writeConversationToDb(newConv);

    // Make userEntry for both users
    var userWrite1 = FirestoreWorker.addConversationInUserData(uId, newConv);
    var userWrite2 = FirestoreWorker.addConversationInUserData(u2Id, newConv);

    await convWrite;
    await userWrite1;
    await userWrite2;

    return newConv;
  }

  Future<List<Conversation>> getAllUserConversations(DbUser user) async {
    var output = new List<Conversation>();

    var userConvs =
        await FirestoreWorker.getAllConversationDocumentsForUser(user);

    userConvs.forEach((snap) {
      var newConv = Conversation.fromSnapshot(snap);
      output.add(newConv);
    });

    return output;
  }

  Future<List<Bike>> getUserBikeList(DbUser user) async {
    var output = new List<Bike>();

    var bikeDocs = await FirestoreWorker.getAllBikeDocumentsForUser(user);

    bikeDocs.forEach((snap) {
      var newBike = Bike.fromSnapshot(snap);
      output.add(newBike);
    });

    return output;
  }

  // DbUser currentChatPartner;
  // StreamSubscription<DocumentSnapshot> chatPartnerSubscription;

  Future<void> chatRoomBetreten(String convId, DbUser user) async {
    var task1 = FirestoreWorker.clearUnreadForConversation(user, convId);
    var task2 = FirestoreWorker.setUserIsInChat(user.uId, convId);
    // chatPartnerSubscription = FirestoreWorker.getUserStream(chatPartnerId).listen((s){
    //   currentChatPartner = DbUser.fromSnapshot(s);
    // });

    await task1;
    await task2;
  }

  Future<void> leaveChatRoom(String convId, DbUser user) async {
    await FirestoreWorker.setUserIsInChat(user.uId, null);
    // chatPartnerSubscription.cancel();
  }

  Stream<QuerySnapshot> getChatMessageStream(String convId,{int maxMessages = 20}) {
    return FirestoreWorker.getMessageStream(convId, limitTo: maxMessages);
  }

  Future<void> writeChatMessage(Conversation conv, DbUser sender, String messageContent, int messageType) async{

    var now = DateTime.now().toUtc().millisecondsSinceEpoch.toString(); // TODO es tritt ein bug auf das messages von verschiedenen Devices falsche timestamps bekommen

    var currentChatPartnerId = (conv.ersteller != sender.uId)? conv.ersteller : conv.adressant;

    var newMessage = Message(
        idFrom: sender.uId,
        idTo: currentChatPartnerId,
        timestamp: now,
        content: messageContent,
        type: messageType);

    await FirestoreWorker.writeMessageTransactionToDb(newMessage, conv.convId);
  }
}
