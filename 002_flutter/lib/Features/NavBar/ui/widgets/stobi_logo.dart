import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/assets/resources.dart';

class StobiLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 10.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 130.0,
                height: 60.0,
                child: Image.asset(
                  stobi_logo_path,
                ),
              )),
        ),
        Transform.translate(
            offset: const Offset(0.0, -25.0),
            child: Divider(
              thickness: 1.15,
              color: Colors.black.withAlpha(200),
              indent: 30.0,
              endIndent: 30.0,
            ))
      ],
    );
  }
}
