// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';

class Mytext extends StatelessWidget {
  Mytext({ Key key, this.text, this.fontWeight, this.fontSize }) : super(key: key);

  String text;
  FontWeight fontWeight;
  double fontSize;

  @override
  Widget build(BuildContext context) {

    return Text(
        this.text,
        style: TextStyle(
          color: Color(0xff1D1F8B),
          fontFamily: "Averta CY",
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),  
      );
  }
}