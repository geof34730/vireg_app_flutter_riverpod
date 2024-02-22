import 'package:flutter/material.dart';


class SnakBar{
  late BuildContext context;
  late String messageSnackBar;
  late String themeSnackBar;
  int duration;

  SnakBar({
    required this.context,
    required this.messageSnackBar,
    required this.themeSnackBar,
    this.duration = 1
  });

  showSnakBar(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              messageSnackBar,

          ),
          backgroundColor: getThemeSnackBar(),
          duration:Duration(seconds: duration),
          showCloseIcon: false,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
      ),
    );
  }

  getThemeSnackBar(){
    late dynamic colorsReturn;
    switch (themeSnackBar) {
      case 'success':
        colorsReturn=Colors.green;
        break;
      case 'error':
        colorsReturn=Colors.red;
        break;
    }
    return colorsReturn;
  }
}