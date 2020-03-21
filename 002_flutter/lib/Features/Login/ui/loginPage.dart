import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/Features/Login/ui/ask_for_name_helper.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';
import 'package:project_stobi/Features/MainPage/ui/startPage.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //State Vars

  MediaQueryData osData;
  FbaseUser user;
  bool readingFinished = false;

  @override
  void initState() {
    super.initState();
    AuthModule.instance.readPreviousUserData().then((dbUser) {
      setState(() {
        user = dbUser; // dbUser is null if there is no Userentry
        readingFinished = true;
      });
    });
  }

  Future<void> waitForOsToLoad() async {
    // Recursive Function executes itself every 50 ms
    if (osData == null)
      await Future.delayed(Duration(milliseconds: 50), () async {
        osData = MediaQuery.of(context);
        await waitForOsToLoad();
      });
  }

  void newUserChoseAName(String chosenName) async {
    setState(() {
      userChoseAName = true;
    });
    user = await AuthModule.instance.createNewUser(chosenName);
    setState(() {});
  }

  bool userChoseAName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: waitForOsToLoad(),
      builder: (context, snapshot) {
        if (osData == null)
          return LoadingWidget(
            loadingText: "Wait for OS to load",
          );
        return StatefulBuilder(
          builder: (context, func) {
            if (!readingFinished)
              return LoadingWidget(
                loadingText: "Alte Userdaten werden geladen",
              );
            if (user == null) // User is New
            if (!userChoseAName)
              return AskForNameHelper(
                nameWasChosenCallback: newUserChoseAName,
              );
            else
              return LoadingWidget(
                loadingText: "Neuer User wird erstellt",
              );

            // return MainPageDepricated(osData: osData, user: user);
            return StartPage();
          },
        );
      },
    ));
  }
}


