import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/config/textStyles.dart';
import 'package:provider/provider.dart';

class NavPageOptions extends StatefulWidget {
  @override
  _NavPageOptionsState createState() => _NavPageOptionsState();
}

class _NavPageOptionsState extends State<NavPageOptions> {
  void pageClicked(Pages page) {
    final navbarManager = Provider.of<SmNavbar>(context, listen: false);
    navbarManager.activePage = page;
    navbarManager.updateNavBar();
  }

  Widget createUnderline(Pages page) {
    return Consumer<SmNavbar>(
      builder: (con, state, ch) {
        if (state.activePage != page) return Container();

        return Transform.translate(
          offset: Offset(0.0, -3.0),
          child: Divider(
            thickness: 1.5,
            color: Colors.black.withAlpha(150),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () => pageClicked(Pages.myBikes),
                  child: Container(
                    width: 70.0,
                    height: 40.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Meine Bikes", style: navigationOptions),
                          createUnderline(Pages.myBikes)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pageClicked(Pages.search),
                  child: Container(
                    width: 70.0,
                    height: 40.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Suche", style: navigationOptions),
                          createUnderline(Pages.search)
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => pageClicked(Pages.chats),
                  child: Container(
                    width: 70.0,
                    height: 40.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Chats", style: navigationOptions),
                          createUnderline(Pages.chats)
                        ],
                      ),
                    ),
                  ),
                ),
                // ,
                // Text("Suche"),
                // Text("Chats"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
