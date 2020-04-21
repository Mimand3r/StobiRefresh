import 'package:STOBI/General/colors.dart';
import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeRegistration/ui/configs/textStyles.dart';
import 'package:STOBI/Features/BikeRegistration/ui/widgets/bike_registration_form.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:STOBI/Features/NavBar/ui/bottom_bar.dart';
import 'package:STOBI/Features/NavBar/ui/nav_bar.dart';
import 'package:provider/provider.dart';

class BikeRegistrationPage extends StatefulWidget {
  @override
  _BikeRegistrationPageState createState() => _BikeRegistrationPageState();
}

class _BikeRegistrationPageState extends State<BikeRegistrationPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: bgroundColor,
          ),
          SafeArea(
            child: NavBar(
              showAddElement: false,
              showNavigation: false,
              showOptions: false,
              showBikeTransferExportButton: false,
              showBikeTransferImportButton: false,
              bottomBar: BottomNavBar(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        "Neues Bike registrieren",
                        style: regNewBikeText,
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  Expanded(
                    child: Container(
                      child:
                          SingleChildScrollView(child: BikeRegistrationForm()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
