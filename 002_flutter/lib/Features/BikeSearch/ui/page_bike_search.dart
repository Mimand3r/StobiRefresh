import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeSearch/ui/page_bike_found.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_user_worker.dart';

class BikeSearchPage extends StatefulWidget {
  @override
  _BikeSearchPageState createState() => _BikeSearchPageState();
}

class _BikeSearchPageState extends State<BikeSearchPage> {
  void rahmenNummerSubmitted(String rNr, BuildContext c) async {
    var isValid = basicValidation(rNr);

    if (!isValid) {
      Scaffold.of(c)
          .showSnackBar(SnackBar(content: Text("Ungültige Rahmennummer")));
      control.clear();
      return;
    }

    setState(() => stage = Stage.BikeWirdGesucht);

    // Check if Bike Exists
    var bike = await FirestoreBikeWorker.getSingleBike(rNr);

    // If not Exists Show message and Clear Controller
    if (bike == null) {
      Scaffold.of(c).showSnackBar(
          SnackBar(content: Text("Fahrrad wurde nicht gefunden")));
      control.clear();
      setState(() => stage = Stage.Normal);
      return;
    }

    // Download Bike Picture Data
    setState(() => stage = Stage.PicturesWerdenGedownloadet);

    var eBike = E_Bike.fromMBike(bike);
    var pics = await eBike.downloadAllBikePictures();

    // Download Owner User Data
    var m_ownerData = await FirestoreUserWorker.getUserData(eBike.currentOwnerId);
    var ownerData = E_User.fromMUser(m_ownerData);

    // Navigate To Bike Found Page
    control.clear();
    setState(() => stage = Stage.Normal);
    Navigator.of(c).push(MaterialPageRoute(
        builder: (c) => PageBikeFound(
              bike: eBike,
              pictures: pics,
              owner: ownerData,
            )));
  }

  bool basicValidation(String rNr) {
    // TODO basic validation of rahmennummern

    // f.e -> numbers only
    return true;
  }

  Future<M_Bike> checkBike() async {}

  TextEditingController control = TextEditingController();

  Stage stage = Stage.Normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NavBar(
          showNavigation: true,
          showAddElement: false,
          showOptions: true,
          showBikeTransferExportButton: false,
          showBikeTransferImportButton: false,
          chosenElement: 2,
          bottomBar: BottomNavBar(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Builder(
                builder: (c) {
                  if (stage == Stage.Normal) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Rahmennummer eingeben"),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 45.0),
                            child: TextField(
                              controller: control,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration.collapsed(
                                  hintText: "hier Rahmennummer eingeben"),
                              onSubmitted: (s) {
                                rahmenNummerSubmitted(s, c);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (stage == Stage.BikeWirdGesucht) {
                    return Center(
                      child: LoadingWidget(loadingText: "Fahrrad wird gesucht"),
                    );
                  } else if (stage == Stage.PicturesWerdenGedownloadet) {
                    return Center(
                      child: LoadingWidget(
                          loadingText:
                              "Fahrrad gefunden. Bilder werden gedownloadet"),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum Stage { Normal, BikeWirdGesucht, PicturesWerdenGedownloadet }
