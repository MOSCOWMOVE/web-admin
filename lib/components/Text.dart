// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';

class Mytext extends StatelessWidget {
  Mytext({ Key key, this.text, this.fontWeight, this.fontSize, this.color, this.centered, this.underline }) : super(key: key);

  String text;
  FontWeight fontWeight;
  double fontSize;
  bool centered = false;
  bool underline = false;
  Color color = Color(0xff141548);

  @override
  Widget build(BuildContext context) {

    return Text(
        this.text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontFamily: "Averta CY",
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: this.underline == null ? TextDecoration.none : TextDecoration.underline
        ), 
        textAlign: ((centered == null) ? TextAlign.center : TextAlign.left),
        maxLines: 3, 
      );
  }
}