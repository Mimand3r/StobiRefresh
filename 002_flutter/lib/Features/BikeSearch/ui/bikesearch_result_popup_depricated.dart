import 'dart:core';
import 'package:flutter/material.dart';
import 'package:project_stobi/General/colors.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types.dart';
import 'package:project_stobi/TechnischeFeatures/Navigation/navigation_helper.dart';

class BikesearchResultPopupDepricated extends StatefulWidget {
  final Bike bike;
  final DbUser user;
  final Future Function(Bike) kontaktiereUserCallback;

  const BikesearchResultPopupDepricated({Key key, @required this.bike, @required this.user, @required this.kontaktiereUserCallback})
      : super(key: key);

  @override
  _BikesearchResultPopupDepricatedState createState() => _BikesearchResultPopupDepricatedState();
}

class _BikesearchResultPopupDepricatedState extends State<BikesearchResultPopupDepricated> {

  void kontaktiereBikeBesitzer(BuildContext context){
    widget.kontaktiereUserCallback(widget.bike);
    NavigationHelper.goBack(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.top_bar_gradient_end,
        title: Text("Fahrrad gefunden"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Text(
              "Gestellnummer \n${widget.bike.gestellNr}",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Modell \n${widget.bike.modell}",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0,
            ),
            StatefulBuilder(
              builder: (con, s) {
                bool belongsToSelf = widget.user.uId == widget.bike.besitzer;

                if (belongsToSelf)
                  return RaisedButton(
                    onPressed: null,
                    textColor: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                    color: AppColors.top_bar_gradient_start,
                    child: Text('Fahrrad gehört dir selbst',
                        style: TextStyle(fontSize: 20)),
                    elevation: 5.0,
                  );
                return RaisedButton(
                  onPressed: () {
                    kontaktiereBikeBesitzer(context);
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                  color: AppColors.top_bar_gradient_start,
                  child: Text('Benutzer kontaktieren',
                      style: TextStyle(fontSize: 20)),
                  elevation: 5.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
