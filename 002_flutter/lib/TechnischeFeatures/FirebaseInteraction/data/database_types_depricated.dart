import 'package:cloud_firestore/cloud_firestore.dart';

class DbUser_depricated {
  String uId;
  String name;
  String photoUrl;
  List<String> registeredBikes;
  List<String> conversations;
  Map<String, int> unreadMessages;
  String isInChat = "";

  DbUser_depricated(
      {this.uId = "",
      this.name = "",
      this.photoUrl = "",
      this.registeredBikes,
      this.conversations,
      this.unreadMessages,
      this.isInChat = ""}) {
    if (registeredBikes == null) registeredBikes = new List<String>();
    if (conversations == null) conversations = new List<String>();
    if (unreadMessages == null) unreadMessages = new Map<String, int>();
  }

  static DbUser_depricated fromSnapshot(DocumentSnapshot snap) {
    return DbUser_depricated(
      uId: snap.data['uId'],
      name: snap.data['name'],
      photoUrl: snap.data['photoUrl'],
      isInChat: snap.data['isInChat'],
      conversations: List<String>.from(snap.data['conversations']),
      registeredBikes: List<String>.from(snap.data['registeredBikes']),
      unreadMessages: Map<String, int>.from(snap.data['unreadMessages']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'uId': this.uId,
      'name': this.name,
      'photoUrl': this.photoUrl,
      'isInChat': this.isInChat,
      'conversations': this.conversations,
      'registeredBikes': this.registeredBikes,
      'unreadMessages': this.unreadMessages,
    };
  }
}

class Bike {
  String gestellNr;
  String besitzer;
  String modell;
  String spitzName;
  String picUrl;

  Bike(
      {this.gestellNr,
      this.besitzer,
      this.modell,
      this.spitzName,
      this.picUrl});

  static Bike fromSnapshot(DocumentSnapshot snap) {
    return Bike(
      gestellNr: snap.data['gestellNr'],
      modell: snap.data['modell'],
      besitzer: snap.data['besitzer'],
      picUrl: snap.data['picUrl'],
      spitzName: snap.data['spitzName'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'gestellNr': this.gestellNr,
      'besitzer': this.besitzer,
      'modell': this.modell,
      'spitzName': this.spitzName,
      'picUrl': this.picUrl
    };
  }
}

class Conversation {
  String convId;
  String ersteller;
  String adressant;
  String fahrradModell;
  String fahrradUrl;
  String fahrradGestellNr;
  int lastMessage;

  Conversation(
      {this.convId,
      this.ersteller,
      this.adressant,
      this.fahrradModell,
      this.fahrradUrl,
      this.fahrradGestellNr,
      this.lastMessage});

  static Conversation fromSnapshot(DocumentSnapshot snap) {
    return Conversation(
        convId: snap.data['convId'],
        ersteller: snap.data['ersteller'],
        adressant: snap.data['adressant'],
        fahrradGestellNr: snap.data['fahrradGestellNr'],
        fahrradModell: snap.data['fahrradModell'],
        fahrradUrl: snap.data['fahrradUrl'],
        lastMessage: snap.data['lastMessage']);
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'convId': this.convId,
      'ersteller': this.ersteller,
      'adressant': this.adressant,
      'fahrradGestellNr': this.fahrradGestellNr,
      'fahrradModell': this.fahrradModell,
      'fahrradUrl': this.fahrradUrl,
      'lastMessage': this.lastMessage,
    };
  }
}

class Message {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  Message({this.idFrom, this.idTo, this.timestamp, this.content, this.type});

  static Message fromSnapshot(DocumentSnapshot snap) {
    return Message(
        idFrom: snap.data['idFrom'],
        idTo: snap.data['idTo'],
        timestamp: snap.data['timestamp'],
        content: snap.data['content'],
        type: snap.data['type']);
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'idFrom': this.idFrom,
      'idTo': this.idTo,
      'timestamp': this.timestamp,
      'content': this.content,
      'type': this.type
    };
  }
}
