import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeTransfer/state/transfer_manager.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:provider/provider.dart';

class BikeHasPINArea extends StatefulWidget {
  final E_Bike bike;
  final void Function() pinGotRemoved;

  const BikeHasPINArea({Key key, this.bike, this.pinGotRemoved})
      : super(key: key);

  @override
  _BikeHasPINAreaState createState() => _BikeHasPINAreaState();
}

class _BikeHasPINAreaState extends State<BikeHasPINArea> {
  void _deletePinKlicked() async {
    var prov = Provider.of<SmTransfer>(context, listen: false);
    setState(() => deletingPin = true);
    await prov.deleteBikePIN(widget.bike);
    widget.pinGotRemoved();
  }

  bool deletingPin = false;

  String _convertMillisecondsToDateString(int milliseconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString()} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    if (deletingPin)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
            child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            Text("Bitte warten PIN wird gelöscht"),
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
              "Für dieses Fahrrad existiert ein Übertragungs PIN. Dieser wurde noch nicht eingelöst",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.bike.transferData.pin,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "generiert für: ${widget.bike.transferData.intendedFor}",
              style: TextStyle(fontSize: 11.0),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "generiert am: " +
                  _convertMillisecondsToDateString(
                      widget.bike.transferData.creation_date_millisecs),
              style: TextStyle(fontSize: 11.0),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: _deletePinKlicked,
              child: Text("pin löschen"),
            )
          ],
        ),
      ),
    );
  }
}
