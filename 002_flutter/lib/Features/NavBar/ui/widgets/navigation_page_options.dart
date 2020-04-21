import 'package:flutter/material.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:STOBI/Features/NavBar/ui/config/textStyles.dart';
import 'package:provider/provider.dart';

class NavPageOptions extends StatefulWidget {
  final int chosenElement;

  const NavPageOptions(this.chosenElement, {Key key}) : super(key: key);

  @override
  _NavPageOptionsState createState() => _NavPageOptionsState();
}

class _NavPageOptionsState extends State<NavPageOptions> {
  void pageClicked(Pages page) {
    if (widget.chosenElement == 1 && page == Pages.myBikes) return;
    if (widget.chosenElement == 2 && page == Pages.search) return;
    if (widget.chosenElement == 3 && page == Pages.chats) return;

    final navbarManager = Provider.of<SmNavbar>(context, listen: false);
    navbarManager.switchToPage(context, page);
  }

  Widget createUnderline(Pages page) {
    var isUnderlined = false;
    if (widget.chosenElement == 1 && page == Pages.myBikes) isUnderlined = true;
    if (widget.chosenElement == 2 && page == Pages.search) isUnderlined = true;
    if (widget.chosenElement == 3 && page == Pages.chats) isUnderlined = true;

    if (isUnderlined)
      return Transform.translate(
        offset: Offset(0.0, -3.0),
        child: Divider(
          thickness: 1.5,
          color: Colors.black.withAlpha(150),
        ),
      );
    else
      return Container();
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
                    color: Colors.transparent,
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
                    color: Colors.transparent,
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
                    color: Colors.transparent,
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
