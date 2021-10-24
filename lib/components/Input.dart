// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Input extends StatelessWidget {
  Input({ Key key, this.onChange }) : super(key: key);

  Function onChange;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder input_border = OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffABABDB),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4)
          );

    return SizedBox(
      height: 32,
      child: TextField(
        onChanged: (e) {
          this.onChange(e);
        },
        cursorColor: Color(0xffABABDB),
        style: TextStyle(
          color: Color(0xffABABDB)
        ),
        decoration: InputDecoration(
          enabledBorder: input_border,
          focusedBorder: input_border,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          fillColor: Color(0xffABABDB),
          focusColor: Color(0xffABABDB),
          hintText: "Найти...",
          hintStyle: GoogleFonts.lato(
            textStyle: TextStyle(
            color: Color(0xffABABDB),
            fontSize: 12,
            fontFamily: "Roboto"
            )
          )
        )
      )
    );
  }
}