import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeDetail/ui/page_bike_detail.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/Features/BikeList/ui/configs/textStyles.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/storage_picture_worker.dart';
import 'package:provider/provider.dart';

class BikeListElement extends StatefulWidget {
  final E_Bike bike;

  const BikeListElement({Key key, this.bike}) : super(key: key);

  @override
  _BikeListElementState createState() => _BikeListElementState();
}

class _BikeListElementState extends State<BikeListElement> {
  @override
  void initState() {
    super.initState();
  }

  void arrowKlicked() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (x) => PageBikeDetail(bike: widget.bike)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: double.infinity,
            height: 140,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                          widget.bike.idData.name != null
                              ? Text(
                                  widget.bike.idData.name,
                                  style: bikeName,
                                )
                              : Text(
                                  widget.bike.idData.modell,
                                  style: bikeName,
                                ),

                          Consumer<SmUserBikeList>(
                            builder: (con, state, child) {
                              return Expanded(
                                child: Container(
                                  child: Hero(
                                      tag: widget.bike.rahmenNummer,
                                      child:
                                          state.getPicturesForSpecificOwnedBike(
                                              widget.bike.rahmenNummer)[0]),
                                ),
                              );
                            },
                          )
                          // else
                          //   Image.asset("assets/pictures/image_loading_gif.gif")
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: arrowKlicked,
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Hero(
                    tag: "border_${widget.bike.rahmenNummer}",
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.7,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

// depricated
// class Line extends StatefulWidget {
//   const Line({Key key, @required this.header, @required this.value})
//       : super(key: key);

//   @override
//   _LineState createState() => _LineState();

//   final String header;
//   final String value;
// }

// // class _LineState extends State<Line> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: <Widget>[
// //         SizedBox(
// //           height: 5,
// //         ),
// //         Row(
// //           children: <Widget>[
// //             Flexible(
// //                 flex: 2,
// //                 child: Container(
// //                   height: 25,
// //                   child: Row(
// //                     children: <Widget>[
// //                       SizedBox(
// //                         width: 10,
// //                       ),
// //                       Text(
// //                         widget.header,
// //                         style: myBikesLight,
// //                       ),
// //                     ],
// //                   ),
// //                 )),
// //             Flexible(
// //                 flex: 3,
// //                 child: Container(
// //                   height: 25,
// //                   child: Center(
// //                       child: Text(
// //                     widget.value,
// //                     style: myBikesStrong,
// //                   )),
// //                 ))
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// class BikePictures extends StatefulWidget {
//   final List<File> pictures;

//   const BikePictures(this.pictures, {Key key}) : super(key: key);

//   @override
//   _BikePicturesState createState() => _BikePicturesState();
// }

// class _BikePicturesState extends State<BikePictures> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.pictures == null) return Container();
//     if (widget.pictures.length == 0) return Container();

//     var picList = <Widget>[];
//     for (var pic in widget.pictures) {
//       picList.add(Container(
//         width: 40,
//         child: Image.file(
//           pic,
//         ),
//       ));
//       picList.add(SizedBox(width: 2));
//     }

//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 5,
//         ),
//         Row(
//           children: <Widget>[
//             Flexible(
//                 flex: 2,
//                 child: Container(
//                   height: 25,
//                   child: Row(
//                     children: <Widget>[
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Bilder x${widget.pictures.length}",
//                         style: myBikesLight,
//                       ),
//                     ],
//                   ),
//                 )),
//             Flexible(
//                 flex: 3,
//                 child: Container(
//                   height: 25,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(children: picList),
//                   ),
//                 ))
//           ],
//         ),
//       ],
//     );
//   }
// }
