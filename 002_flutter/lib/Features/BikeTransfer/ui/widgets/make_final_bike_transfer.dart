import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeDetail/ui/page_bike_detail.dart';
import 'package:STOBI/Features/BikeTransfer/state/transfer_manager.dart';
import 'package:STOBI/Features/Login/ui/widgets/loading_widget.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';
import 'package:provider/provider.dart';

class MakeFinalBikeTransfer extends StatefulWidget {
  final String pin;
  final E_Bike bike;

  const MakeFinalBikeTransfer({Key key, this.pin, this.bike}) : super(key: key);

  @override
  _MakeFinalBikeTransferState createState() => _MakeFinalBikeTransferState();
}

class _MakeFinalBikeTransferState extends State<MakeFinalBikeTransfer> {
  @override
  void initState() {
    super.initState();
    downloadAllPictues();
    downloadBikeOwner();

    // currentBug: bei Pin Creation kann es vorkommen das global Pin Entry erzeugt wird. Die lokalen BiketransferDaten aber null bleiben
  }

  Future<void> downloadAllPictues() async {
    pictures = await widget.bike.downloadAllBikePictures();
    if (mounted) setState(() {});
  }

  Future<void> downloadBikeOwner() async {
    currentBikeOwner = await widget.bike.fullOwnerData;
    if (mounted) setState(() {});
  }

  String createDateStringFromMilliseconds(int millisecondsSinceEpoch) {
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return "${date.day}.${date.month}.${date.year} - ${date.hour}:${date.minute} Uhr";
  }

  void fahrradBeanspruchenClicked() {
    setState(() => uebertraegtBike = true);
  }

  Future<void> transferBike() async {
    var prov = Provider.of<SmTransfer>(context, listen: false);
    await prov.transferBikeToMyself(widget.bike, pictures);

    Navigator.of(context).pop();

    Navigator.of(context).push(new MaterialPageRoute(
        builder: (x) => PageBikeDetail(bike: widget.bike)));

  }

  List<Image> pictures;
  E_User currentBikeOwner;

  bool uebertraegtBike = false;

  @override
  Widget build(BuildContext context) {
    if (uebertraegtBike)
      return FutureBuilder(
          future: transferBike(),
          builder: (c, s) {
            if (s.connectionState != ConnectionState.done) {
              return Center(child: LoadingWidget(loadingText: "Fahrrad  wird übertragen"));
            }
            return Container();
          });

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Text("Unter der PIN wurde ein Fahrrad gefunden"),
          SizedBox(
            height: 30,
          ),
          if (pictures != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: pictures[0],
            ),
          SizedBox(
            height: 20,
          ),
          Text("RahmenNr:"),
          Text(widget.bike.rahmenNummer),
          SizedBox(
            height: 20,
          ),
          Text("Hersteller:"),
          Text(widget.bike.idData.hersteller),
          SizedBox(
            height: 20,
          ),
          Text("Modell:"),
          Text(widget.bike.idData.modell),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Text("Das Fahrrad wurde für den Transfer markiert"),
          SizedBox(
            height: 20,
          ),
          Text("Aktueller Besitzer"),
          if (currentBikeOwner != null) Text(currentBikeOwner.name),
          SizedBox(
            height: 20,
          ),
          Text("Fahrrad ist gedacht für"),
          Text(widget.bike.transferData.intendedFor),
          SizedBox(
            height: 20,
          ),
          Text("Pin wurde generiert am"),
          Text(createDateStringFromMilliseconds(
              widget.bike.transferData.creation_date_millisecs)),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: fahrradBeanspruchenClicked,
            child: Text("Fahrrad beanspruchen"),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
