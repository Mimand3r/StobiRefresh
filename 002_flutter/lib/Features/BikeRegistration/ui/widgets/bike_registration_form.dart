import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/configs/colors.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/configs/textStyles.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/fbaseUser.dart';

class BikeRegistrationForm extends StatefulWidget {
  BikeRegistrationForm({Key key}) : super(key: key);

  @override
  _BikeRegistrationFormState createState() => _BikeRegistrationFormState();
}

class _BikeRegistrationFormState extends State<BikeRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _hersteller;
  String _modell;
  String _art;
  String _groesse;
  String _name;
  String _rahmennummer;
  String _versicherungsgesellschaft;
  String _versicherungsnummer;
  String _herstellerfarbbezeichnung;
  String _zubehoer;
  String _beschreibung;

  void addFileClicked() {}

  void saveFormClicked() async {
    final form = _formKey.currentState;

    if (!form.validate()) return;

    form.save();

    setState(() => currentlySavingBike = true);

    var newBike = Bike(
      rahmenNummer: _rahmennummer,
      idData: BikeIdData(
        name: _name,
        art: _art,
        beschreibung: _beschreibung,
        farbe: _herstellerfarbbezeichnung,
        groesse: _groesse,
        hersteller: _hersteller,
        modell: _modell,
        registerDate: DateTime.now().millisecondsSinceEpoch, // TODO register Date
      ),
      versicherungsData: BikeVersicherungsData(
          nummer: _versicherungsnummer,
          gesellschaft: _versicherungsgesellschaft),
    );

    var oldUserData = AuthModule.instance.getLoggedInUser();
    oldUserData.bikes.add(newBike);

    await AuthModule.instance.changeUserData(oldUserData);

    Navigator.of(context).pop();

  }

  bool currentlySavingBike = false;

  @override
  Widget build(BuildContext context) {
    if (currentlySavingBike)
      return Center(
        child: Text("Currently Saving Bike"),
      );
    else
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FormBox(
              label: "Hersteller",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Hersteller muss angegeben werden";
                return null;
              },
              onSaved: (s) => _hersteller = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Modell",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Modell muss angegeben werden";
                return null;
              },
              onSaved: (s) => _modell = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Art",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Art muss angegeben werden";
                return null;
              },
              onSaved: (s) => _art = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Größe",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Groesse muss angegeben werden";
                return null;
              },
              onSaved: (s) => _groesse = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Name",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Name muss angegeben werden";
                return null;
              },
              onSaved: (s) => _name = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Rahmennummer",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0) return "Rahmennummer muss angegeben werden";
                return null;
              },
              onSaved: (s) => _rahmennummer = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Versicherungsgesellschaft",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0)
                  return "Versicherungsgesellschaft muss angegeben werden";
                return null;
              },
              onSaved: (s) => _versicherungsgesellschaft = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Versicherungsnummer",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0)
                  return "Versicherungsnummer muss angegeben werden";
                return null;
              },
              onSaved: (s) => _versicherungsnummer = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Herstellerfarbbezeichnung",
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0)
                  return "Herstellerfarbbezeichnung muss angegeben werden";
                return null;
              },
              onSaved: (s) => _herstellerfarbbezeichnung = s,
            ),
            SizedBox(
              height: 35,
            ),
            FormBox(
              label: "Zubehör",
              keyboardType: TextInputType.text,
              validator: (v) {
                // if (v.length == 0) return "Zubehör muss angegeben werden";
                return null;
              },
              onSaved: (s) => _zubehoer = s,
            ),
            SizedBox(
              height: 35,
            ),
            FormMultiline(
              label: "Beschreibung",
              keyboardType: TextInputType.text,
              validator: (v) => null,
              onSaved: (s) => _beschreibung = s,
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: addFileClicked,
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.description,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: saveFormClicked,
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                        child: Text(
                      "Save",
                      style: saveButtonText,
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
  }
}

class FormBox extends StatefulWidget {
  final String label;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final TextInputType keyboardType;

  const FormBox(
      {Key key, this.label, this.validator, this.keyboardType, this.onSaved})
      : super(key: key);

  @override
  _FormBoxState createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Theme(
        data: formFieldTheme,
        child: TextFormField(
          style: formTypedText,
          decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}

class FormMultiline extends StatefulWidget {
  final String label;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final TextInputType keyboardType;

  const FormMultiline(
      {Key key, this.label, this.validator, this.onSaved, this.keyboardType})
      : super(key: key);

  @override
  _FormMultilineState createState() => _FormMultilineState();
}

class _FormMultilineState extends State<FormMultiline> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Theme(
        data: formFieldTheme,
        child: TextFormField(
          style: formTypedText,
          maxLines: null,
          minLines: 5,
          decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
