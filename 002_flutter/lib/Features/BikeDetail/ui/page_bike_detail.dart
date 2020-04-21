import 'dart:io';

import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeDetail/ui/config/textStyles.dart';
import 'package:STOBI/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:STOBI/Features/Login/ui/widgets/loading_widget.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:STOBI/Features/NavBar/ui/bottom_bar.dart';
import 'package:STOBI/Features/NavBar/ui/nav_bar.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:provider/provider.dart';

class PageBikeDetail extends StatefulWidget {
  final E_Bike bike;

  const PageBikeDetail({Key key, this.bike}) : super(key: key);

  @override
  _PageBikeDetailState createState() => _PageBikeDetailState();
}

class _PageBikeDetailState extends State<PageBikeDetail> {
  @override
  void initState() {
    super.initState();

    var prov = Provider.of<SmNavbar>(context, listen: false);
    prov.selectedBike = widget.bike;
  }

  void verlorenMelden() async {
    setState(() => pageState = PageState.wirdAlsVerlorenGemeldet);
    await FirestoreBikeWorker.changeBikeLostState(
        true, widget.bike.rahmenNummer);
    widget.bike.registeredAsStolen = true;
    setState(() => pageState = PageState.normal);
  }

  void gefundenMelden() async {
    setState(() => pageState = PageState.wirdAlsGefundenGemeldet);
    await FirestoreBikeWorker.changeBikeLostState(
        false, widget.bike.rahmenNummer);
    widget.bike.registeredAsStolen = false;
    setState(() => pageState = PageState.normal);
  }

  PageState pageState = PageState.normal;

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
                child: Builder(builder: (c) {
                  if (pageState == PageState.wirdAlsGefundenGemeldet)
                    return Center(
                      child: LoadingWidget(
                          loadingText:
                              "Bitte Warten. Fahrrad wird als gefunden gemeldet"),
                    );

                  if (pageState == PageState.wirdAlsVerlorenGemeldet)
                    return Center(
                      child: LoadingWidget(
                          loadingText:
                              "Bitte Warten. Fahrrad wird als verloren gemeldet"),
                    );

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 230,
                          height: 230,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Consumer<SmUserBikeList>(
                                    builder: (con, state, child) {
                                      return Hero(
                                        tag: widget.bike.rahmenNummer,
                                        child: state
                                            .getPicturesForSpecificOwnedBike(
                                                widget.bike.rahmenNummer)[0],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "border_${widget.bike.rahmenNummer}",
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Builder(builder: (c) {
                          if (widget.bike.registeredAsStolen) {
                            return Column(
                              children: <Widget>[
                                Text("Fahrrad ist als verloren gemeldet",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                                RaisedButton(
                                  onPressed: gefundenMelden,
                                  child: Text("Fahrrad gefunden"),
                                )
                              ],
                            );
                          } else if (!widget.bike.registeredAsStolen)
                            return Column(
                              children: <Widget>[
                                Text("Fahrrad ist nicht als verloren gemeldet",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                                RaisedButton(
                                  onPressed: verlorenMelden,
                                  child: Text("Fahrrad verloren"),
                                )
                              ],
                            );
                        }),
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
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum PageState {
  normal,
  wirdAlsVerlorenGemeldet,
  wirdAlsGefundenGemeldet,
}

class DataField extends StatefulWidget {
  final String val;

  const DataField(this.val, {Key key}) : super(key: key);

  @override
  _DataFieldState createState() => _DataFieldState();
}

class _DataFieldState extends State<DataField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 40,
      decoration: BoxDecoration(border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.val,
            style: fieldStyle,
          ),
        ),
      ),
    );
  }
}
