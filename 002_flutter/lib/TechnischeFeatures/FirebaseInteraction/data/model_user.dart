import 'package:cloud_firestore/cloud_firestore.dart';

class M_User {
  String uId;
  String name;
  String photoUrl;
  String pushToken;

  List<String> bikes;

  M_User({
    this.uId = "",
    this.name = "",
    this.photoUrl = "",
    this.bikes,
    this.pushToken,
  }) {
    if (bikes == null) bikes = new List<String>();
  }

  static M_User fromSnapshot(DocumentSnapshot snap) => M_User(
        uId: snap.data['uId'],
        name: snap.data['name'],
        photoUrl: snap.data['photoUrl'],
        pushToken: snap.data['pushToken'],
        bikes: List<String>.from(snap.data["bikes"]),
      );

  Map<String, dynamic> toSnapshot() => {
        'uId': this.uId,
        'name': this.name,
        'photoUrl': this.photoUrl,
        'pushToken': this.pushToken,
        'bikes': this.bikes,
      };
}
