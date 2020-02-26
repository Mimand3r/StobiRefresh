import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/ui/page_mybikes.dart';
import 'package:project_stobi/Features/BikeSearch/ui/page_bike_search.dart';
import 'package:project_stobi/Features/Chat/ui/chat_page.dart';
import 'package:project_stobi/Features/MainPage/ui/startPage.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            child: NavBar(),
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 105.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Consumer<SmNavbar>(
                builder: (context, state, child) {
                  switch (state.activePage) {
                    case Pages.none:
                      return StartPage();
                    case Pages.myBikes:
                      return Column(
                        children: <Widget>[
                          PageMyBikes(),
                          BottomNavBar(isPopup: false,)
                        ],
                      );
                    case Pages.search:
                      return Column(
                        children: <Widget>[
                          BikeSearchPage(),
                          BottomNavBar(isPopup: false,)
                        ],
                      );
                    case Pages.chats:
                      return Column(
                        children: <Widget>[
                          ChatPage(),
                          BottomNavBar(isPopup: false,)
                        ],
                      );
                    default:
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
