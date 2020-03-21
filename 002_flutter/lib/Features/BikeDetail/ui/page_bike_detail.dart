import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeDetail/ui/config/textStyles.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/Features/BikeList/ui/widgets/bike_list_element.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';
import 'package:provider/provider.dart';

class PageBikeDetail extends StatefulWidget {
  final FbaseBike bike;
  final List<File> pictures;
  final Image firstPicture;

  const PageBikeDetail({Key key, this.bike, this.pictures, this.firstPicture})
      : super(key: key);

  @override
  _PageBikeDetailState createState() => _PageBikeDetailState();
}

class _PageBikeDetailState extends State<PageBikeDetail> {

  @override
  void initState() {
    super.initState();

    var prov = Provider.of<SmNavbar>(context, listen: false);
    prov.selectedBike = widget.bike;
    prov.selectedBikePicture = widget.firstPicture;
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
                      Container(
                        width: 230,
                        height: 230,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Hero(
                                  tag: widget.bike.rahmenNummer,
                                  child: widget.firstPicture,
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
