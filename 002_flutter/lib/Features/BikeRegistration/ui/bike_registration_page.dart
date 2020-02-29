
import 'package:project_stobi/General/colors.dart';
import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/configs/textStyles.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/widgets/bike_registration_form.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar_logo_only.dart';
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
            child: Stack(
              children: <Widget>[
                Align(
                  child: NavBarLogoOnly(),
                  alignment: Alignment.topCenter,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
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
                        child: SingleChildScrollView(
                            child: BikeRegistrationForm()),
                      ),
                    ),
                    BottomNavBar(
                      isPopup: true,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
