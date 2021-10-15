import 'package:flutter/material.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;


    return Container(
      height: height,
      width: width/8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10)
        ),
        boxShadow: [
            BoxShadow(
            color: Color.fromRGBO(0,0,0,0.12),
            blurRadius: 20,
            offset: Offset.fromDirection(0,-8),
            spreadRadius: 0
          )
        ]
      ),
    );
  }
}