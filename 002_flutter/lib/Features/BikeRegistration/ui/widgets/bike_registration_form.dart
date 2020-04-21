import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:STOBI/Features/BikeRegistration/state/registration_manager.dart';
import 'package:STOBI/Features/BikeRegistration/ui/configs/colors.dart';
import 'package:STOBI/Features/BikeRegistration/ui/configs/textStyles.dart';
import 'package:STOBI/Features/BikeRegistration/ui/widgets/form_images.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';
import 'package:provider/provider.dart';

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

  void _addFileClicked() async {
    // Open Gallery and Choose Picture
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    // Store Picture in Local List and update SetState
    setState(() => localImageList.add(image));
  }

  void _addPhotoClicked() async {
    // Open Gallery and Choose Picture
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    // Store Picture in Local List and update SetState
    setState(() => localImageList.add(image));
  }

  void _saveFormClicked() async {
    final form = _formKey.currentState;

    if (!form.validate()) return;

    form.save();

    setState(() => currentlySavingBike = true);

    var newBike = E_Bike(
      rahmenNummer: _rahmennummer,
      registeredAsStolen: false,
      idData: BikeIdData(
        name: _name,
        art: _art,
        beschreibung: _beschreibung,
        farbe: _herstellerfarbbezeichnung,
        groesse: _groesse,
        hersteller: _hersteller,
        modell: _modell,
        registerDate: DateTime.now().millisecondsSinceEpoch,
      ),
      versicherungsData: BikeVersicherungsData(
          nummer: _versicherungsnummer,
          gesellschaft: _versicherungsgesellschaft),
    );

    var regManager = Provider.of<SmRegistrationManager>(context, listen: false);

    await regManager.registerBike(context, newBike, localImageList);

    Navigator.of(context).pop();
  }

  void _removePicture(int index) =>
      setState(() => localImageList.removeAt(index));

  bool currentlySavingBike = false;

  List<File> localImageList = <File>[];

  @override
  Widget build(BuildContext context) {
    if (currentlySavingBike)
      return Center(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Currently Saving Bike"),
          ],
        ),
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
              label: "Rahmennummer",
              keyboardType: TextInputType.text,
              isOptional: false,
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
              label: "Name",
              keyboardType: TextInputType.text,
              isOptional: true,
              validator: (v) {
                // if (v.length == 0) return "Name muss angegeben werden";
                return null;
              },
              onSaved: (s) => _name = s,
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                ),
                Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "Details",
                        style: dividerText,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Art",
              keyboardType: TextInputType.text,
              isOptional: false,
              validator: (v) {
                // if (v.length == 0) return "Art muss angegeben werden";
                return null;
              },
              onSaved: (s) => _art = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Modell",
              keyboardType: TextInputType.text,
              isOptional: false,
              validator: (v) {
                // if (v.length == 0) return "Modell muss angegeben werden";
                return null;
              },
              onSaved: (s) => _modell = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Größe",
              keyboardType: TextInputType.text,
              isOptional: false,
              validator: (v) {
                // if (v.length == 0) return "Groesse muss angegeben werden";
                return null;
              },
              onSaved: (s) => _groesse = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Hersteller",
              keyboardType: TextInputType.text,
              isOptional: false,
              validator: (v) {
                // if (v.length == 0) return "Hersteller muss angegeben werden";
                return null;
              },
              onSaved: (s) => _hersteller = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Farbe",
              keyboardType: TextInputType.text,
              isOptional: false,
              validator: (v) {
                if (v.length == 0)
                  // return "Herstellerfarbbezeichnung muss angegeben werden";
                  return null;
              },
              onSaved: (s) => _herstellerfarbbezeichnung = s,
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Zubehör",
              keyboardType: TextInputType.text,
              isOptional: false,
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
              height: 25,
            ),
            Stack(
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                ),
                Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "Versicherung",
                        style: dividerText,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            FormBox(
              label: "Versicherungsgesellschaft",
              isOptional: false,
              keyboardType: TextInputType.text,
              validator: (v) {
                if (v.length == 0)
                  // return "Versicherungsgesellschaft muss angegeben werden";
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
              isOptional: false,
              validator: (v) {
                if (v.length == 0)
                  // return "Versicherungsnummer muss angegeben werden";
                  return null;
              },
              onSaved: (s) => _versicherungsnummer = s,
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                ),
                Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "Bilder",
                        style: dividerText,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            FormLocalImages(
              importedImages: localImageList,
              removePictureCallback: _removePicture,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _addFileClicked,
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
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: _addPhotoClicked,
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.camera_enhance,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: _saveFormClicked,
              child: Container(
                width: 260,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                    child: Text(
                  "Speichern",
                  style: saveButtonText,
                )),
              ),
            ),
            SizedBox(
              height: 30,
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
  final bool isOptional;

  const FormBox(
      {Key key,
      this.label,
      this.validator,
      this.keyboardType,
      this.onSaved,
      this.isOptional})
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
            helperText: widget.isOptional ? "Optional" : null,
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
