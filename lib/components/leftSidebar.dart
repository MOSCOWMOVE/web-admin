import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20)
        ),
        boxShadow: [
            BoxShadow(
            color: Color.fromRGBO(0,0,0,0.12),
            blurRadius: 20,
            spreadRadius: 0
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.all(47),
        child: Column(
          children: [
          ],
        )
      )
    );
  }
}