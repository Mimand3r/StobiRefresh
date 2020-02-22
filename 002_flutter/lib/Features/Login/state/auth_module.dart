import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModule {
  
  // Singleton
  AuthModule._privateConstructor();
  static final AuthModule instance = AuthModule._privateConstructor();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  Future<DbUser> readPreviousUserData() async{
    prefs = await SharedPreferences.getInstance();

    var uId = prefs.getString("uId"); 
    if (uId == null) return null; 

    return await FirestoreWorker.readUserFromDb(uId);
 
  }

  Future<DbUser> createUser(String name) async {
    AuthResult authResult = await firebaseAuth.signInAnonymously();
    var authUser = authResult.user;
    
    var userData = UserUpdateInfo();
    userData.displayName = name;
    userData.photoUrl = "defaultPhotoUrl";
    try{
      authUser.updateProfile(userData);
    }
    on Exception{}
    
    prefs = await SharedPreferences.getInstance();
    prefs.setString("uId", authUser.uid);

    return await FirestoreModule.instance.createNewUser(authUser.uid, name); 
  }

}

