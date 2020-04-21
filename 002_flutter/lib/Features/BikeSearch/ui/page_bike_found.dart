import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeDetail/ui/page_bike_detail.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';

class PageBikeFound extends StatefulWidget {
  final E_Bike bike;
  final List<Image> pictures;
  final E_User owner;

  const PageBikeFound({Key key, this.bike, this.pictures, this.owner})
      : super(key: key);

  @override
  _PageBikeFoundState createState() => _PageBikeFoundState();
}

class _PageBikeFoundState extends State<PageBikeFound> {
  void kontaktierenPressed() {
    // If user = urself show error message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NavBar(
          showNavigation: false,
          showAddElement: true,
          showOptions: false,
          showBikeTransferExportButton: true,
          showBikeTransferImportButton: false,
          bottomBar: BottomNavBar(),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Für diese Rahmennummer wurde ein Eintrag gefunden",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.bike.rahmenNummer,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Eingetragener Besitzer ist"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.owner.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RaisedButton(
                          onPressed: kontaktierenPressed,
                          child: Text("Besitzer kontaktieren")),
                      SizedBox(
                        height: 20,
                      ),
                      if (widget.bike.registeredAsStolen)
                        Text("Fahrrad ist als verloren gemeldet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      if (!widget.bike.registeredAsStolen)
                        Text("Fahrrad ist nicht als verloren gemeldet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 230,
                        height: 230,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: widget.pictures[0],
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Column(
                            children: <Widget>[
                              DataField(widget.bike.idData.name),
                              SizedBox(height: 10),
                              DataField(widget.bike.idData.art),
                              SizedBox(height: 10),
                              DataField(widget.bike.idData.hersteller),
                              SizedBox(height: 10),
                              DataField(widget.bike.rahmenNummer),
                              SizedBox(height: 10),
                              DataField(widget.bike.idData.groesse),
                              SizedBox(height: 10),
                              DataField(widget.bike.idData.farbe),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
