import 'package:flutter/material.dart';
import 'package:project_stobi/General/colors.dart';

class NavigationBarDepricated extends StatefulWidget {
  NavigationBarDepricated(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.topPadding,
      @required this.currentActivePage,
      @required this.settingsDropdownReference,
      @required this.userWantsPageSwitchCallback,
      @required this.hasActiveChats,
      @required this.unreadMessages})
      : super(key: key);

  final double height;
  final double width;
  final double topPadding;
  final int currentActivePage;
  final bool hasActiveChats;
  final int unreadMessages;

  final Widget settingsDropdownReference;
  final void Function(int) userWantsPageSwitchCallback;

  _NavigationBarDepricatedState createState() => _NavigationBarDepricatedState();
}

class _NavigationBarDepricatedState extends State<NavigationBarDepricated> {

  double logoWidth;
  double logoHeight;
  double logoPosX;
  double logoPosY;

  double iconWidth;
  double iconHeight;
  double iconPosX;
  double iconPosY;

  double tapElementHeight;

  List<TextStyle> pageButtonTextStyles = List<TextStyle>();
  Alignment schiebereglerPosition;

  @override
  void initState() {
    super.initState();
    calculateLogoSize();
    calculateIconSize();
    calculateTapElementSize();
  }

  // Setup Functions

  void calculateLogoSize() {
    logoWidth = (0.1778 * widget.width).roundToDouble();
    logoHeight = (0.43 * widget.height).roundToDouble();
    logoPosX = (0.064 * widget.width).roundToDouble();
    logoPosY = (0.0645 * widget.height + widget.topPadding)
        .roundToDouble();
  }

  void calculateIconSize() {
    iconHeight = (0.3763 * widget.height).roundToDouble();
    iconWidth = iconHeight;
    iconPosX = (0.875 * widget.width).roundToDouble();
    iconPosY = (0.1183 * widget.height + widget.topPadding)
        .roundToDouble();
  }

  void calculateTapElementSize() {
    tapElementHeight = (0.505376 * widget.height).roundToDouble();
  }

  // Page Dynamics

  void makeBoldTextForActivePage() {
    pageButtonTextStyles.clear();
    for (var i = 0; i < 3; i++) {
      if (widget.currentActivePage == i) {
        pageButtonTextStyles.add(TextStyle(
            color: (i == 2 && !widget.hasActiveChats)
                ? Color(0x0BFFFFFF)
                : Colors.white,
            fontFamily: "MsPhagsPha",
            fontWeight: FontWeight.w700));
      } else {
        pageButtonTextStyles.add(TextStyle(
            color: (i == 2 && !widget.hasActiveChats)
                ? Color(0x1BFFFFFF)
                : Colors.white,
            fontFamily: "MsPhagsPha"));
      }
    }
  }

  void positioniereSchieberegler(){
    switch (widget.currentActivePage) {
      case 0:
        schiebereglerPosition = Alignment.bottomLeft;
        break;
      case 1:
        schiebereglerPosition = Alignment.bottomCenter;
        break;
      case 2:
        schiebereglerPosition = Alignment.bottomRight;
        break;
    }
  }

  // User Interaction Functions

  void pageIconGotTapped(BuildContext context, int index) {
    widget.userWantsPageSwitchCallback(index);
  }

  @override
  Widget build(BuildContext context) {

    makeBoldTextForActivePage();
    positioniereSchieberegler();

    return Stack(
      children: <Widget>[
        // Hintergrund
        Container(
            height: widget.height + widget.topPadding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.top_bar_gradient_start,
                    AppColors.top_bar_gradient_end
                  ]),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0x28000000),
                    offset: Offset(0.0, 6.0),
                    blurRadius: 2.0)
              ],
            ),
            // Page - Buttons
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () {
                          pageIconGotTapped(context, 0);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                            width: 0.33333 * widget.width,
                            height: tapElementHeight,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  height: 20 / 47 * tapElementHeight,
                                  width: 42 /
                                      120 *
                                      0.33333 *
                                      widget.width,
                                  left: 39 /
                                      120 *
                                      0.33333 *
                                      widget.width,
                                  top: 14 / 47 * tapElementHeight,
                                  child: FittedBox(
                                      child: Text(
                                    "Suche",
                                    style: pageButtonTextStyles[0],
                                  )),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          pageIconGotTapped(context, 1);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                            width: 0.33333 * widget.width,
                            height: tapElementHeight,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  height: 35 / 47 * tapElementHeight,
                                  width: 64 /
                                      120 *
                                      0.33333 *
                                      widget.width,
                                  left: 28 /
                                      120 *
                                      0.33333 *
                                      widget.width,
                                  top: 6 / 47 * tapElementHeight,
                                  child: FittedBox(
                                      child: Text(
                                    "meine\nFahrräder",
                                    textAlign: TextAlign.center,
                                    style: pageButtonTextStyles[1],
                                  )),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.hasActiveChats)
                              pageIconGotTapped(context, 2);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                              width:
                                  0.33333 * widget.width,
                              height: tapElementHeight,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    height: 20 / 47 * tapElementHeight,
                                    width: 36 /
                                        120 *
                                        0.33333 *
                                        widget.width,
                                    left: 42 /
                                        120 *
                                        0.33333 *
                                        widget.width,
                                    top: 14 / 47 * tapElementHeight,
                                    child: FittedBox(
                                        child: Text(
                                      "Chats",
                                      textAlign: TextAlign.center,
                                      style: pageButtonTextStyles[2],
                                    )),
                                  ),
                                  if (widget.unreadMessages > 0)
                                    Positioned(
                                      height: 14 / 47 * tapElementHeight,
                                      width: 14 / 47 * tapElementHeight,
                                      left: 82 /
                                          120 *
                                          0.33333 *
                                          widget.width,
                                      top: 19 / 47 * tapElementHeight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: FittedBox(
                                          child: Text(
                                            "${widget.unreadMessages}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .top_bar_gradient_start),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              )),
                        ))
                  ],
                ),
                // Schieberegler
                Align(
                  alignment: schiebereglerPosition,
                  child: Container(
                    width: 0.33333 * widget.width,
                    height: 6 / 47 * tapElementHeight,
                    decoration: BoxDecoration(
                      color: AppColors.top_bar_schieberegler,
                      borderRadius: BorderRadius.all(Radius.circular(2.0))
                    ),
                  ),
                )
              ],
            )),
        // Logo
        Positioned(
          height: logoHeight,
          width: logoWidth,
          left: logoPosX,
          top: logoPosY,
          child: FittedBox(
            child: Text(
              "stobi",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PalatinoLinotype',
                  shadows: <Shadow>[
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 6.0)
                  ]),
            ),
          ),
        ),
        // SettingsIcon
        Positioned(
          height: iconHeight,
          width: iconWidth,
          left: iconPosX,
          top: iconPosY,
          child: widget.settingsDropdownReference,
        ),
      ],
    );
  }
}
