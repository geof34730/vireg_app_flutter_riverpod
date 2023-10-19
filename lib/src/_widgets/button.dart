import 'package:flutter/material.dart';
ButtonStyle getButtonStyleLang({required String lang, required String localLang}) => ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>((localLang == lang ? Colors.green : Colors.blue)));

