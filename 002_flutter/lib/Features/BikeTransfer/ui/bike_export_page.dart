import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeTransfer/configs/textStyles.dart';
import 'package:project_stobi/Features/BikeTransfer/ui/widgets/create_new_pin_area.dart';
import 'package:project_stobi/Features/BikeTransfer/ui/widgets/pin_already_exists_area.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';

class BikeExportPage extends StatefulWidget {
  final FbaseBike bike;
  final Image firstPicture;

  const BikeExportPage(
      {Key key, @required this.bike, @required this.firstPicture})
      : super(key: key);

  @override
  _BikeExportPageState createState() => _BikeExportPageState();
}

class _BikeExportPageState extends State<BikeExportPage> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Übertrage an anderen User",
                      style: exportText,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Center(
                    child: Hero(
                      tag: widget.bike.rahmenNummer,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          child: widget.firstPicture,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      widget.bike.idData.name,
                      style: bikeNameText,
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.bike.rahmenNummer,
                      style: rahmenNrText,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (widget.bike.transferData != null)
                    PinExistsArea(
                      bike: widget.bike,
                      pinGotRemoved: () {
                        setState(() {});
                      },
                    )
                  else
                    CreateNewPinArea(
                      bike: widget.bike,
                      pinGotCreated: () {
                        setState(() {});
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
