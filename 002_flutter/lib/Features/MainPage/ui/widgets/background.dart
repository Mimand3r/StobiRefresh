import 'package:flutter/material.dart';
import 'package:STOBI/General/colors.dart';

class Background extends StatelessWidget {
  Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background_gradient_start,
            AppColors.background_gradient_end,
          ]
        )
      ),
      );
  }
}
