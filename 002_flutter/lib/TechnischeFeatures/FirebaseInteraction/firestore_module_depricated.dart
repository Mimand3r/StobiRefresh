import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types_depricated.dart';

import 'firestore_worker_depricated.dart';

class FirestoreModule_depricated {
  // Singleton
  FirestoreModule_depricated._privateConstructor();
  static final FirestoreModule_depricated instance = FirestoreModule_depricated._privateConstructor();

  Future<DbUser_depricated> createNewUser(String uId, String name) async {
    var dbUser = DbUser_depricated(uId: uId, name: name);
    await FirestoreWorker_depricated.writeUserToDb(dbUser);

    return dbUser;
  }

  StreamSubscription<DocumentSnapshot> listenToUserChanges(
      DbUser_depricated user, void Function(DbUser_depricated) userGotChangedCallback) {
    var userSubscription = FirestoreWorker_depricated.getUserStream(user.uId).listen((s) {
      var newUser = DbUser_depricated.fromSnapshot(s);
      userGotChangedCallback(newUser);
    });

    return userSubscription;
  }

  Future<Bike> registerABike(DbUser_depricated owner, String gestellNr, String modell,
      String spitzName, String picUrl) async {
    // Check if Bike already Exists
    var oldBike = await FirestoreWorker_depricated.readBikeFromDb(gestellNr);
    if (oldBike != null) throw Exception("Bike was already registered");

    var bike = Bike(
        gestellNr: gestellNr,
        besitzer: owner.uId,
        modell: modell,
        spitzName: spitzName,
        picUrl: picUrl);

    var writeBikeDb = FirestoreWorker_depricated.writeBikeToDb(bike);
    var writeUserDb = FirestoreWorker_depricated.registerBikeInUserData(owner.uId, bike);

    await writeBikeDb;
    await writeUserDb;

    return bike;
  }

  Future<Bike> searchABike(String gestellNr) async {
    var bike = await FirestoreWorker_depricated.readBikeFromDb(gestellNr);

    return bike;
  }

  Future<Conversation> erstelleNeueKonversationMitFahrradBesitzer(
      DbUser_depricated user, Bike fahrrad) async {
    // Create a ConvId
    var uId = user.uId;
    var u2Id = fahrrad.besitzer;
    var convId = (uId.hashCode >= u2Id.hashCode) ? '$uId-$u2Id' : '$u2Id-$uId';

    // Check if Conversation already Exists
    var existingConv = await FirestoreWorker_depricated.readConversationFromDb(convId);
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

    var convWrite = FirestoreWorker_depricated.writeConversationToDb(newConv);

    // Make userEntry for both users
    var userWrite1 = FirestoreWorker_depricated.addConversationInUserData(uId, newConv);
    var userWrite2 = FirestoreWorker_depricated.addConversationInUserData(u2Id, newConv);

    await convWrite;
    await userWrite1;
    await userWrite2;

    return newConv;
  }

  Future<List<Conversation>> getAllUserConversations(DbUser_depricated user) async {
    var output = new List<Conversation>();

    var userConvs =
        await FirestoreWorker_depricated.getAllConversationDocumentsForUser(user);

    userConvs.forEach((snap) {
      var newConv = Conversation.fromSnapshot(snap);
      output.add(newConv);
    });

    return output;
  }

  Future<List<Bike>> getUserBikeList(DbUser_depricated user) async {
    var output = new List<Bike>();

    var bikeDocs = await FirestoreWorker_depricated.getAllBikeDocumentsForUser(user);

    bikeDocs.forEach((snap) {
      var newBike = Bike.fromSnapshot(snap);
      output.add(newBike);
    });

    return output;
  }

  // DbUser currentChatPartner;
  // StreamSubscription<DocumentSnapshot> chatPartnerSubscription;

  Future<void> chatRoomBetreten(String convId, DbUser_depricated user) async {
    var task1 = FirestoreWorker_depricated.clearUnreadForConversation(user, convId);
    var task2 = FirestoreWorker_depricated.setUserIsInChat(user.uId, convId);
    // chatPartnerSubscription = FirestoreWorker.getUserStream(chatPartnerId).listen((s){
    //   currentChatPartner = DbUser.fromSnapshot(s);
    // });

    await task1;
    await task2;
  }

  Future<void> leaveChatRoom(String convId, DbUser_depricated user) async {
    await FirestoreWorker_depricated.setUserIsInChat(user.uId, null);
    // chatPartnerSubscription.cancel();
  }

  Stream<QuerySnapshot> getChatMessageStream(String convId,{int maxMessages = 20}) {
    return FirestoreWorker_depricated.getMessageStream(convId, limitTo: maxMessages);
  }

  Future<void> writeChatMessage(Conversation conv, DbUser_depricated sender, String messageContent, int messageType) async{

    var now = DateTime.now().toUtc().millisecondsSinceEpoch.toString(); // TODO es tritt ein bug auf das messages von verschiedenen Devices falsche timestamps bekommen

    var currentChatPartnerId = (conv.ersteller != sender.uId)? conv.ersteller : conv.adressant;

    var newMessage = Message(
        idFrom: sender.uId,
        idTo: currentChatPartnerId,
        timestamp: now,
        content: messageContent,
        type: messageType);

    await FirestoreWorker_depricated.writeMessageTransactionToDb(newMessage, conv.convId);
  }
}
