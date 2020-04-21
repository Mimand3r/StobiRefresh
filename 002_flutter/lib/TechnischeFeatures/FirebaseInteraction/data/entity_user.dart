
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/model_user.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'entity_bike.dart';

class E_User {
  String uId;
  String name;
  String photoUrl;
  String pushToken;

  List<String> ownedBikesNummernListe;

  E_User({
    this.uId = "",
    this.name = "",
    this.photoUrl = "",
    this.ownedBikesNummernListe,
    this.pushToken,
  }) {
    if (ownedBikesNummernListe == null)
      ownedBikesNummernListe = new List<String>();
  }

  static E_User fromMUser(M_User user) {
    if (user == null) return null;

    var output = new E_User(
        uId: user.uId,
        name: user.name,
        photoUrl: user.photoUrl,
        pushToken: null,
        ownedBikesNummernListe: user.bikes);

    return output;
  }

  M_User convertToMUser() => M_User(
      name: this.name,
      uId: this.uId,
      photoUrl: this.photoUrl,
      pushToken: this.pushToken,
      bikes: this.ownedBikesNummernListe);

  Future<List<E_Bike>> downloadUserBikeData() async {
    var mBikeList =
        await FirestoreBikeWorker.getMultipleBikes(this.ownedBikesNummernListe);
    var eBikeList = new List<E_Bike>();
    mBikeList.forEach((bike) => eBikeList.add(E_Bike.fromMBike(bike)));

    return eBikeList;
  }




}
