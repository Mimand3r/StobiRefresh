import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModule with ChangeNotifier {
  // Singleton
  AuthModule._privateConstructor();
  static final AuthModule instance = AuthModule._privateConstructor();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  FbaseUser _loggedInUser;

  FbaseUser getLoggedInUser() => _loggedInUser;

  Future changeUserData(FbaseUser newData) async {
    await FireStoreWorker.writeUserToDb(newData);
    _loggedInUser = newData;
    notifyListeners();
  }

  Future<FbaseUser> readPreviousUserData() async {
    prefs = await SharedPreferences.getInstance();

    var uId = prefs.getString("uId");
    if (uId == null) return null;

    _loggedInUser = await FireStoreWorker.readUserFromDb(uId); // Can be null
    return _loggedInUser;
  }

  Future<FbaseUser> createNewUser(String name) async {
    // Using Anonymous Auth for uID creation
    AuthResult authResult = await firebaseAuth.signInAnonymously();
    var authUser = authResult.user;

    var userData = UserUpdateInfo();
    userData.displayName = name;
    userData.photoUrl = "defaultPhotoUrl";
    try {
      authUser.updateProfile(userData);
    } on Exception {}

    prefs = await SharedPreferences.getInstance();
    prefs.setString("uId", authUser.uid);

    var newUser = FbaseUser(
        bikes: createNewUserDummyBikeList(authUser.uid),
        name: name,
        uId: authUser.uid,
        photoUrl: null,
        pushToken: null // TODO pushToken for new User
        );

    try {
      await FireStoreWorker.writeUserToDb(newUser);
    } on Exception {
      _loggedInUser = null;
      return null;
    }

    _loggedInUser = newUser;
    return newUser;
  }

  List<FbaseBike> createNewUserDummyBikeList(String uId) {
    var newUserBikeList = new List<FbaseBike>();

    for (var i = 1; i <= 9; i++) {
      var dummyBike = new FbaseBike(currentOwner: uId)
        ..rahmenNummer = uId + i.toString();
      if (i != 9) dummyBike.pictures = <String>["bike00${i.toString()}.jpg"];
      dummyBike.idData = new BikeIdData(
          name: "Beispiel Fahrrad " + i.toString(),
          art: "Mountainbike",
          farbe: "Blau",
          groesse: "176cm",
          hersteller: "Triban",
          modell: "RC 100",
          registerDate: 0,
          beschreibung:
              "Ein hypotethisches Beispiel-Fahrrad. Existiert nicht real");
      dummyBike.versicherungsData =
          BikeVersicherungsData(nummer: "111", gesellschaft: "AOV");

      newUserBikeList.add(dummyBike);
    }

    return newUserBikeList;
  }
}
