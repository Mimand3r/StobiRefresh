import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';
import 'package:project_stobi/General/colors.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types.dart';

class MyBikesPageDepricated extends StatefulWidget {
  MyBikesPageDepricated(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.user,
      @required this.currentlyRegisteringABike,
      @required this.currentlyGettingBikeList,
      @required this.bikeList})
      : super(key: key);

  final double height;
  final double width;
  final DbUser user;
  final bool currentlyRegisteringABike;
  final bool currentlyGettingBikeList;
  final List<Bike> bikeList;

  @override
  _MyBikesPageDepricatedState createState() => _MyBikesPageDepricatedState();
}

class _MyBikesPageDepricatedState extends State<MyBikesPageDepricated> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentlyRegisteringABike)
      return LoadingWidget(
        loadingText: "Fahrrad wird gerade registriert",
      );

    if (widget.currentlyGettingBikeList)
      return LoadingWidget(
        loadingText: "Fahrradliste wird geladen",
      );

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.bikeList.length,
      itemBuilder: (context, i) {
        return Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.top_bar_gradient_end,
            ),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  width: 50.0,
                  height: 50.0,
                  // margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage('assets/pictures/anonymousBike.jpg'))),
                ),
                title: Text(
                  widget.bikeList[i].spitzName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text("Modell: ${widget.bikeList[i].modell}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Text("GestellNr: ${widget.bikeList[i].gestellNr}",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0)),
          ),
        );
      },
    );
  }
}
