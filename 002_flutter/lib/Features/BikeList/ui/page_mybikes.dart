import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/Features/BikeList/ui/widgets/bike_list_element.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class PageMyBikes extends StatefulWidget {
  @override
  _PageMyBikesState createState() => _PageMyBikesState();
}

class _PageMyBikesState extends State<PageMyBikes> {
  @override
  Widget build(BuildContext context) {
    // Peformance warning. Setting ProviderState each Frame (initstate introduced pop-bug)
    var navbarManager = Provider.of<SmNavbar>(context, listen: false);

    Future.microtask(() {
      navbarManager.showOptions = false;
      navbarManager.showAddElement = true;
      navbarManager.updateNavBar();
    });

    return Expanded(
      child: Container(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
    );
  }

  @override
  void deactivate() {
    final navbarManager = Provider.of<SmNavbar>(context, listen: false);

    Future.microtask(() {
      navbarManager.showOptions = true;
      navbarManager.showAddElement = false;
      navbarManager.updateNavBar();
    });
    super.deactivate();
  }
}
