import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/add_element.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/stobi_logo.dart';
import 'package:provider/provider.dart';

import 'widgets/navigation_page_options.dart';
import 'widgets/navigation_settings.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SmNavbar>(
      builder: (context, state, child) {
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                if (state.showLogo) StobiLogo(),
                if (state.showPageNavigation) NavPageOptions(),
              ],
            ),
            if (state.showOptions) NavSettings(),
            if (state.showAddElement) AddElement(),
          ],
        );
      },
    );
  }
}
