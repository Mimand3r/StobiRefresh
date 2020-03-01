import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/configs/textStyles.dart';

class FormLocalImages extends StatefulWidget {
  final List<File> importedImages;
  final void Function(int) removePictureCallback;

  const FormLocalImages(
      {Key key, this.importedImages, this.removePictureCallback})
      : super(key: key);

  @override
  _FormLocalImagesState createState() => _FormLocalImagesState();
}

class _FormLocalImagesState extends State<FormLocalImages> {
  @override
  Widget build(BuildContext context) {
    if (widget.importedImages != null) if (widget.importedImages.length > 0) {
      var pictureList = <Widget>[];

      for (var i = 0; i < widget.importedImages.length; i++) {
        var image = Image.file(
          widget.importedImages[i],
          fit: BoxFit.contain,
        );

        pictureList.addAll(<Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              if (i != 0)
                Row(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, -8),
                      child: Container(
                        color: Colors.black,
                        width: 2.0,
                        height: 70.0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              Column(
                children: <Widget>[
                  Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.up,
                    dismissThresholds: {DismissDirection.up: 100.0},
                    background: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        color: Colors.redAccent,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("löschen", style: pictureDeleteText,),
                          )),
                      ),
                    ),
                    onDismissed: (d) {
                      setState(() => widget.removePictureCallback(i));
                    },
                    child: Container(
                      height: 100,
                      child: image,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Bild ${i + 1}/${widget.importedImages.length}",
                    style: pictureCountingText,
                  )
                ],
              ),
            ],
          ),
        ]);
      }

      widget.importedImages.forEach((i) {});

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: pictureList,
          ),
        ),
      );
    }

    return Container(
      width: 100,
      height: 100,
      child: Image.asset(
        "assets/pictures/NoPictures.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
