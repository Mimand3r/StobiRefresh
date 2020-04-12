import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/Features/Login/state/sm_auth_module.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';
import 'package:project_stobi/Features/MainPage/ui/config/texts.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    invokeListManagerProviderEarly();
    readPrevUserData();
  }

  Future invokeListManagerProviderEarly() async {
    var prov = Provider.of<SmUserBikeList>(context, listen: false);
  }

  Future readPrevUserData() async {
    var prov = Provider.of<SmAuthModule>(context, listen: false);
    var prevUserData = await prov.readPreviousUserData();
    if (prevUserData == null) throw Exception("Unexpected Error");
    scheduleMicrotask(() => setState(() => userData = prevUserData));
  }

  E_User userData;

  @override
  Widget build(BuildContext context) {
    if (userData == null)
      return Scaffold(
        body: Center(
          child: LoadingWidget(loadingText: "Userdaten werden gedownloadet"),
        ),
      );

    return SafeArea(
      child: Scaffold(
        body: NavBar(
          showNavigation: true,
          showAddElement: false,
          showOptions: true,
          showBikeTransferExportButton: false,
          showBikeTransferImportButton: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 220.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.black, width: 0.7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(child: startPageText),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Color(0xffF70705),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(3.0),
                            bottomLeft: Radius.circular(3.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: Offset(0.0, 3.0),
                                blurRadius: 4.0,
                                color: Colors.black.withAlpha(150))
                          ]),
                      child: Center(child: bikeVerloren),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Color(0xffd4d4d4),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3.0),
                            topRight: Radius.circular(3.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: Offset(0.0, 3.0),
                                blurRadius: 4.0,
                                color: Colors.black.withAlpha(150))
                          ]),
                      child: Center(child: bikeGefunden),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
