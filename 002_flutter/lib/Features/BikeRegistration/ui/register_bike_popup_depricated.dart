import 'package:flutter/material.dart';
import 'package:project_stobi/General/colors.dart';
// import 'package:project_stobi/TechnischeFeatures/Navigation/navigation_helper.dart';

class RegisterBikePopupDepricated extends StatefulWidget {
  final double width;
  final Future Function(String, String, String) userRegisteredBikeCallback;

  RegisterBikePopupDepricated(
      {Key key,
      @required this.width,
      @required this.userRegisteredBikeCallback})
      : super(key: key);

  _RegisterBikePopupDepricatedState createState() => _RegisterBikePopupDepricatedState();
}

class _RegisterBikePopupDepricatedState extends State<RegisterBikePopupDepricated> {
  FocusNode gstlNrFocusNode = new FocusNode();
  TextEditingController gstlNrController = TextEditingController();
  FocusNode modellFocusNode = new FocusNode();
  TextEditingController modellController = TextEditingController();
  FocusNode spitznameFocusNode = new FocusNode();
  TextEditingController spitznameController = TextEditingController();

  void registerButtonKlicked(BuildContext context) {
    if (gstlNrController.text == "" ||
        modellController.text == "" ||
        spitznameController.text == "") return;
    widget.userRegisteredBikeCallback(
        gstlNrController.text, modellController.text, spitznameController.text);
    // NavigationHelper.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        gstlNrFocusNode.unfocus();
        modellFocusNode.unfocus();
        spitznameFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.top_bar_gradient_end,
          title: Text("Fahrrad registrieren"),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            // GestellNummer
            Container(
              margin: EdgeInsets.only(
                  left: 64 / 360 * widget.width,
                  right: 64 / 360 * widget.width),
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xff000000),
                  cursorColor: Colors.black,
                ),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.only(top: 15.0),
                    hintStyle: TextStyle(color: Color(0x30000000)),
                    labelText: "Gestellnummer eingeben",
                  ),
                  onFieldSubmitted: (s){modellFocusNode.requestFocus();},
                  focusNode: gstlNrFocusNode,
                  controller: gstlNrController,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            // Modell
            Container(
              margin: EdgeInsets.only(
                  left: 64 / 360 * widget.width,
                  right: 64 / 360 * widget.width),
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xff000000),
                  cursorColor: Colors.black,
                ),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.only(top: 15.0),
                    hintStyle: TextStyle(color: Color(0x30000000)),
                    labelText: "Modellbezeichnung eingeben",
                  ),
                  focusNode: modellFocusNode,
                  controller: modellController,
                  onFieldSubmitted: (s){spitznameFocusNode.requestFocus();},
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            // Spitzname
            Container(
              margin: EdgeInsets.only(
                  left: 64 / 360 * widget.width,
                  right: 64 / 360 * widget.width),
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xff000000),
                  cursorColor: Colors.black,
                ),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.only(top: 15.0),
                    hintStyle: TextStyle(color: Color(0x30000000)),
                    labelText: "Spitznamen festlegen",
                  ),
                  focusNode: spitznameFocusNode,
                  controller: spitznameController,
                  onFieldSubmitted: (s){registerButtonKlicked(context);},
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            // Button
            RaisedButton(
              onPressed: () {
                registerButtonKlicked(context);
              },
              textColor: Colors.white,
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
              color: AppColors.top_bar_gradient_start,
              child: Text('registrieren', style: TextStyle(fontSize: 20)),
              elevation: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
