import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ElevatedButtonCardHome({required dynamic onClickButton,  required String label, required IconData iconContent, required int indexRubrique, required BuildContext context}) {
  return ElevatedButton.icon(
    onPressed: () {
      onClickButton();
    },
    style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 5.00, right: 12.00, top: 0.00, bottom: 0.00)),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        elevation: const MaterialStatePropertyAll(5),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ))),
    icon: Icon(iconContent, size: 15.0, color: Colors.black),
    label: Text(
      label,
      style: GoogleFonts.sourceSans3(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 13,
            height: 1.2,
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}