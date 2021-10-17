// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Input extends StatelessWidget {
  const Input({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder input_border = OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff5A5CD8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4)
          );

    return SizedBox(
      height: 32,
      child: TextField(
        cursorColor: Color(0xff5A5CD8),
        style: TextStyle(
          color: Color(0xff1D1F8B)
        ),
        decoration: InputDecoration(
          enabledBorder: input_border,
          focusedBorder: input_border,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          fillColor: Color(0xff5A5CD8),
          focusColor: Color(0xff5A5CD8),
          hintText: "Найти...",
          hintStyle: GoogleFonts.lato(
            textStyle: TextStyle(
            color: Color(0xff5A5CD8),
            fontSize: 12,
            fontFamily: "Roboto"
            )
          )
        )
      )
    );
  }
}