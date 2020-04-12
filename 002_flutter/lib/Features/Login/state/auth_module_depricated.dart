// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types_depricated.dart';
// import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_module_depricated.dart';
// import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker_depricated.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthModule_depricated {
  
//   // Singleton
//   AuthModule_depricated._privateConstructor();
//   static final AuthModule_depricated instance = AuthModule_depricated._privateConstructor();

//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   SharedPreferences prefs;

//   Future<DbUser_depricated> readPreviousUserData() async{
//     prefs = await SharedPreferences.getInstance();

//     var uId = prefs.getString("uId"); 
//     if (uId == null) return null; 

//     return await FirestoreWorker_depricated.readUserFromDb(uId);
 
//   }

//   Future<DbUser_depricated> createUser(String name) async {
//     AuthResult authResult = await firebaseAuth.signInAnonymously();
//     var authUser = authResult.user;
    
//     var userData = UserUpdateInfo();
//     userData.displayName = name;
//     userData.photoUrl = "defaultPhotoUrl";
//     try{
//       authUser.updateProfile(userData);
//     }
//     on Exception{}
    
//     prefs = await SharedPreferences.getInstance();
//     prefs.setString("uId", authUser.uid);

//     return await FirestoreModule_depricated.instance.createNewUser(authUser.uid, name); 
//   }

// }

