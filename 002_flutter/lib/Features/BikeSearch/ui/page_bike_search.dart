import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';

class BikeSearchPage extends StatefulWidget {
  @override
  _BikeSearchPageState createState() => _BikeSearchPageState();
}

class _BikeSearchPageState extends State<BikeSearchPage> {
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
              color: Colors.red,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text("BikeSearch"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
