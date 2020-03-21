import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeTransfer/ui/widgets/make_final_bike_transfer.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';

class BikeImportPage extends StatefulWidget {
  @override
  _BikeImportPageState createState() => _BikeImportPageState();
}

class _BikeImportPageState extends State<BikeImportPage> {
  void _pinEinloesenKlicked(BuildContext context) async {
    if (controller.text.length == 0) return;
    setState(() => currentlyCheckingPIN = true);
  }

  // Returns null when PIN is unvalid
  Future<FbaseBike> validatePIN() async { // Invoked by FutureBuilder

    var pin = controller.text;

    await Future.delayed(Duration(seconds: 3));
    return FbaseBike();
  }

  var controller = TextEditingController();
  var currentlyCheckingPIN = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NavBar(
        showAddElement: false,
        showBikeTransferExportButton: false,
        showBikeTransferImportButton: false,
        showNavigation: false,
        showOptions: false,
        bottomBar: BottomNavBar(),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Builder(builder: (c) {
              if (!currentlyCheckingPIN)
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                        "Pin einlösen",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Hier PIN eingeben"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        controller: controller,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        onPressed: () => _pinEinloesenKlicked(context),
                        child: Text("Pin einlösen"),
                      )
                    ],
                  ),
                );
              return FutureBuilder<FbaseBike>(
                  future: validatePIN(),
                  builder: (c, snap) {
                    if (snap.connectionState != ConnectionState.done)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(height: 20,),
                          Text("PIN wird geprüft"),
                        ],
                      );

                    if (snap.data == null) 
                      return Center(child: Text("Eingegebener PIN war ungültig"));

                    return MakeFinalBikeTransfer(pin: controller.text, bike: snap.data);
                    
                  });
            })),
      )),
    );
  }
}
