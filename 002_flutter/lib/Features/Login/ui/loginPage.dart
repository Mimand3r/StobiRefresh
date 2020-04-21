import 'dart:async';

import 'package:flutter/material.dart';
import 'package:STOBI/Features/Login/state/sm_auth_module.dart';
import 'package:STOBI/Features/Login/ui/widgets/loading_widget.dart';
import 'package:STOBI/Features/Login/ui/widgets/test_user_decisionpage.dart';
import 'package:STOBI/Features/MainPage/ui/startPage.dart';
import 'package:provider/provider.dart';

import 'widgets/ask_for_name_helper.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> waitForOsToLoad() async {
    // Recursive Function executes itself every 50 ms
    MediaQueryData osData;

    while (osData == null) {
      osData = MediaQuery.of(context);
      if (osData == null) await Future.delayed(Duration(milliseconds: 50));
    }
    scheduleMicrotask(() => setState(() => currentStage = Stages.CheckingUser));
  }

  String prevUserName;

  Future checkIfPreviousUserExists() async {
    var prov = Provider.of<SmAuthModule>(context, listen: false);
    var prevExists = await prov.checkIfPreviousUserExists();
    if (prevExists.isNotEmpty) {
      prevUserName = prevExists;
      scheduleMicrotask(() =>
          setState(() => currentStage = Stages.DecisionToUsePreviousUser));
    } else
      scheduleMicrotask(
          () => setState(() => currentStage = Stages.WaitForTypingUserName));
  }

  void newUserChoseAName(String chosenName) async {
    scheduleMicrotask(() => setState(() => currentStage = Stages.CreatingUser));

    var prov = Provider.of<SmAuthModule>(context, listen: false);
    var new_user = await prov.createNewUser(chosenName);
    _goToStartPage();
  }

  void createNewUserClicked() => scheduleMicrotask(
      () => setState(() => currentStage = Stages.WaitForTypingUserName));

  void keepOldUserClicked() => _goToStartPage();

  void _goToStartPage() async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => StartPage()), (r) => false);
  }

  Stages currentStage = Stages.LoadingOS;

  @override
  Widget build(BuildContext context) {
    // Stage OS Load
    if (currentStage == Stages.LoadingOS)
      return Scaffold(
        body: FutureBuilder(
          future: waitForOsToLoad(),
          builder: (c, snap) {
            if (snap.connectionState != ConnectionState.done)
              return LoadingWidget(
                loadingText: "Wait for OS to load",
              );
            return Container();
          },
        ),
      );

    // Stage Check User Entrys
    if (currentStage == Stages.CheckingUser)
      return Scaffold(
        body: FutureBuilder(
          future: checkIfPreviousUserExists(),
          builder: (c, snap) {
            if (snap.connectionState != ConnectionState.done)
              return LoadingWidget(
                loadingText: "Alte Usereinträge werden geprüft",
              );
            return Container();
          },
        ),
      );

    // Stage Wait for User Typing new Name
    if (currentStage == Stages.WaitForTypingUserName)
      return Scaffold(
        body: AskForNameHelper(
          nameWasChosenCallback: newUserChoseAName,
        ),
      );

    // Stage Wait for User Creation
    if (currentStage == Stages.CreatingUser)
      return Scaffold(
          body: Center(
              child: LoadingWidget(
        loadingText: "Neuer User wird angelegt",
      )));

    // Stage Decision To Use PreviousUser
    if (currentStage == Stages.DecisionToUsePreviousUser)
      return TestUserDecisionPage(
          previousUserName: prevUserName,
          createNewUserClicked: createNewUserClicked,
          keepOldUserClicked: keepOldUserClicked);
  }
}

enum Stages {
  LoadingOS,
  CheckingUser,
  DecisionToUsePreviousUser,
  WaitForTypingUserName,
  CreatingUser
}
