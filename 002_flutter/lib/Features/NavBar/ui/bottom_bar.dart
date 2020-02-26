import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/assets/resources.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {

  final bool isPopup;

  const BottomNavBar({Key key, this.isPopup}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void backGotClicked() {
    if (widget.isPopup){
      Navigator.of(context).pop();
      return;
    }
    
    final navbarManager = Provider.of<SmNavbar>(context, listen: false);
    navbarManager.activePage = Pages.none;
    navbarManager.updateNavBar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: backGotClicked,
              child: Container(child: Image.asset(back_button_path)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
