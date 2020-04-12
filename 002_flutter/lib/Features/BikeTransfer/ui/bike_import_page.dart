import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeTransfer/state/transfer_manager.dart';
import 'package:project_stobi/Features/BikeTransfer/ui/widgets/make_final_bike_transfer.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/Managers/UserManager.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:provider/provider.dart';

class BikeImportPage extends StatefulWidget {
  @override
  _BikeImportPageState createState() => _BikeImportPageState();
}

class _BikeImportPageState extends State<BikeImportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _pinEinloesenKlicked(BuildContext context) async {
    if (controller.text.length == 0) return;
    setState(() => currentlyCheckingPIN = true);
  }

  // Returns null when PIN is unvalid
  Future<E_Bike> validatePIN() async {
    // Invoked by FutureBuilder
    var pin = controller.text;
    var prov = Provider.of<SmTransfer>(context, listen: false);
    var newBike = await prov.tryGetABikeFromPIN(pin);
    return newBike;
  }

  void pinWarUngueltig(BuildContext c) {
    Scaffold.of(c).showSnackBar(SnackBar(content: Text("Pin war ungültig")));
    controller.clear();
    setState(() => currentlyCheckingPIN = false);
  }

  void pinGehoertDirSelbst(BuildContext c) {
    Scaffold.of(c).showSnackBar(SnackBar(
        content: Text(
            "Pin gehört zu einem deiner Fahrräder.\nBitte gebe den PIN eines anderen Users ein.")));
    controller.clear();
    setState(() => currentlyCheckingPIN = false);
  }

  var controller = TextEditingController();
  var currentlyCheckingPIN = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              return FutureBuilder<E_Bike>(
                  future: validatePIN(),
                  builder: (c, snap) {
                    if (snap.connectionState != ConnectionState.done)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text("PIN wird geprüft"),
                        ],
                      );

                    if (snap.data == null)
                      return Builder(builder: (c) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => pinWarUngueltig(c));
                        return Center();
                      });

                    if (snap.data.currentOwnerId ==
                        UserManager.instance.getCurrentUser.uId)
                      return Builder(builder: (c) {
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => pinGehoertDirSelbst(c));
                        return Center();
                      });

                    return MakeFinalBikeTransfer(
                        pin: controller.text, bike: snap.data);
                  });
            })),
      )),
    );
  }
}
