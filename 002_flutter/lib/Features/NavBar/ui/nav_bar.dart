import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/bottom_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/add_element.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/bike_transfer_export_button.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/bike_transfer_import_button.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/stobi_logo.dart';
import 'package:provider/provider.dart';

import 'widgets/navigation_page_options.dart';
import 'widgets/navigation_settings.dart';

class NavBar extends StatefulWidget {
  final bool showOptions;
  final bool showAddElement;
  final bool showNavigation;
  final bool showBikeTransferExportButton;
  final bool showBikeTransferImportButton;
  final int chosenElement;
  final Widget child;
  final BottomNavBar bottomBar;

  const NavBar(
      {Key key,
      @required this.showOptions,
      @required this.showAddElement,
      @required this.showNavigation,
      @required this.child,
      this.chosenElement,
      this.bottomBar,
      @required this.showBikeTransferExportButton,
      @required this.showBikeTransferImportButton})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: "topBar",
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    StobiLogo(),
                    if (widget.showNavigation)
                      NavPageOptions(widget.chosenElement),
                  ],
                ),
                if (widget.showOptions) NavSettings(),
                if (widget.showAddElement) AddElement(),
                if (widget.showBikeTransferExportButton)
                  BikeTransferExportButton(),
                if (widget.showBikeTransferImportButton)
                  BikeTransferImportButton(),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Column(
            children: <Widget>[
              Expanded(child: widget.child),
              if (widget.bottomBar != null)
                Consumer<SmNavbar>(
                  builder: (c, s, ch) {
                    if (s.hiddenBottomBar) return Container();

                    return Align(
                        alignment: Alignment.bottomCenter,
                        child: widget.bottomBar);
                  },
                )
            ],
          ),
        )
      ],
    );
  }
}
