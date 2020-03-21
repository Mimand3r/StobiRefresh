import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeTransfer/state/transfer_manager.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:provider/provider.dart';

class CreateNewPinArea extends StatefulWidget {
  final FbaseBike bike;
  final void Function() pinGotCreated;

  const CreateNewPinArea({Key key, this.bike, this.pinGotCreated}) : super(key: key);

  @override
  _CreateNewPinAreaState createState() => _CreateNewPinAreaState();
}

class _CreateNewPinAreaState extends State<CreateNewPinArea> {
  void _createPinKlicked() async {
    if (textController.text.length == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Bitte Namen des Empfängers eingeben"),
        duration: Duration(milliseconds: 1500),
      ));
      return;
    }

    setState(() => creatingPin = true);

    var prov = Provider.of<SmTransfer>(context, listen: false);
    await prov.createNewBikePIN(widget.bike, textController.text);

    widget.pinGotCreated();
  }

  var focusNode = FocusNode();
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_focusChanged);
  }

  @override
  void dispose() {
    focusNode.removeListener(_focusChanged);
    super.dispose();
  }

  // Hides Bottom Navbar if Keyboard appears
  void _focusChanged() {
    var navManager = Provider.of<SmNavbar>(context, listen: false);
    navManager.changeBottomBarVisibility(focusNode.hasFocus);
  }

  var creatingPin = false;

  @override
  Widget build(BuildContext context) {
    if (creatingPin)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
            child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text("Bitte warten Pin wird erzeugt")
          ],
        )),
      );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Für dieses Fahrrad existiert noch kein Übertragungs PIN",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Pin erstellen Für",
              style: TextStyle(fontSize: 11.0),
            ),
            SizedBox(
              height: 0,
            ),
            Center(
              child: TextField(
                focusNode: focusNode,
                controller: textController,
                decoration: InputDecoration.collapsed(
                    hintText: "Namen des Empfängers eingeben"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: _createPinKlicked,
              child: Text("Pin erzeugen"),
            )
          ],
        ),
      ),
    );
  }
}
