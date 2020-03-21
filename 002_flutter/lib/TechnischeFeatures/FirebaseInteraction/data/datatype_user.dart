import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';

class FbaseUser {
  String uId;
  String name;
  String photoUrl;
  String pushToken;

  List<FbaseBike> bikes;

  FbaseUser(
      {this.uId = "",
      this.name = "",
      this.photoUrl = "",
      this.bikes,
      this.pushToken}) {
    if (bikes == null) bikes = new List<FbaseBike>();
  }

  static FbaseUser fromSnapshot(DocumentSnapshot snap) {
    var bikeListSnapshot = FbaseBike.listFromSnapshot(snap.data["bikes"]);

    return FbaseUser(
        uId: snap.data['uId'],
        name: snap.data['name'],
        photoUrl: snap.data['photoUrl'],
        pushToken: snap.data['pushToken'],
        bikes: bikeListSnapshot);
  }

  Map<String, dynamic> toSnapshot() {
    var bikeListSnap = FbaseBike.listToSnapshot(this.bikes);

    return {
      'uId': this.uId,
      'name': this.name,
      'photoUrl': this.photoUrl,
      'pushToken': this.pushToken,
      'bikes': bikeListSnap,
    };
  }
}

