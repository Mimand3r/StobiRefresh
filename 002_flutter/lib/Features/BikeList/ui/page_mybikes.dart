import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/Features/BikeList/ui/widgets/bike_list_element.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:provider/provider.dart';

class PageMyBikes extends StatefulWidget {
  @override
  _PageMyBikesState createState() => _PageMyBikesState();
}

class _PageMyBikesState extends State<PageMyBikes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: NavBar(
            showAddElement: true,
            showOptions: false,
            showNavigation: true,
            showBikeTransferExportButton: false,
            showBikeTransferImportButton: true,
            chosenElement: 1,
            bottomBar: BottomNavBar(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Consumer<SmUserBikeList>(
                    builder: (con, state, child) {
                      var bikeList = state.getUserBikes();
                      var bikeWidgets = <Widget>[
                        for (var i = 0; i < bikeList.length; i++)
                          BikeListElement(bike: bikeList[i])
                      ];

                      if (bikeList.length == 0)
                        return Center(
                          child: Text("Noch keine bikes"),
                        );

                      return SingleChildScrollView(
                          child: Column(children: bikeWidgets));
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
