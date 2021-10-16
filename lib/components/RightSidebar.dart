import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RightSidebar extends StatelessWidget {
  RightSidebar({ Key key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: 277,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        boxShadow: [
            BoxShadow(
            color: Color.fromRGBO(0,0,0,0.12),
            blurRadius: 20,
            offset: Offset.fromDirection(0,8),
            spreadRadius: 0
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(47),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/logo.svg"),
            Text(
              "Главная"
            )
          ],
        )
      )
    );
  }
}