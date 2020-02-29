import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/fbaseUser.dart';
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
        bikes: createNewUserDummyBikeList(),
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

  List<Bike> createNewUserDummyBikeList() {
    var newUserBikeList = new List<Bike>();

    for (var i = 0; i < 10; i++) {
      var dummyBike = new Bike()
        ..rahmenNummer = "dummyBike " + (i + 1).toString();
      dummyBike.idData = new BikeIdData(
          name: "Dummy Bike " + (i + 1).toString(),
          art: "Mountainbike",
          farbe: "Dummy Farben",
          groesse: "gigantisch",
          hersteller: "Dummy Fabrikant",
          modell: "Dummy 03",
          registerDate: 0,
          beschreibung: "Ein Dummy Fahrrad");
      dummyBike.versicherungsData = BikeVersicherungsData(
        nummer: "111",
        gesellschaft: "AOV"
      );

      newUserBikeList.add(dummyBike);
    }

    return newUserBikeList;
  }
}
