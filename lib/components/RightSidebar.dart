import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  RightSidebar({ Key key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: width/8,
      height: height,
      child: Container(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10)
        ),
        boxShadow: [
            BoxShadow(
            color: Color.fromRGBO(0,0,0,0.12),
            blurRadius: 20,
            offset: Offset.fromDirection(0,8),
            spreadRadius: 0
          )
        ]
      ),
    );
  }
}