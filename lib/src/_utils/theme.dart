import 'package:flutter/material.dart';

ThemeData getThemeData(){
  return ThemeData(
    //useMaterial3:true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 12.00, bottom: 14.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.transparent),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Color(0xFF455A64)),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Color(0xFF455A64)),
          borderRadius: BorderRadius.circular(5),
        )),
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleSpacing: 0.0,
      centerTitle: true,
      elevation: 15,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: Colors.red,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    dataTableTheme:DataTableThemeData(headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue), headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
      elevation: 15.00,
    ),
  );
}