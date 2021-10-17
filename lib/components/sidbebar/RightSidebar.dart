// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moscow_move_mobile/components/DropDownLists/SportTypesList.dart';
import 'package:moscow_move_mobile/components/Text.dart';
import 'package:moscow_move_mobile/components/DropDownLists/DropDownList.dart';
import 'package:moscow_move_mobile/components/sidbebar/BaseSidebar.dart';

class RightSidebar extends StatelessWidget {
  RightSidebar({ Key key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BaseSidebar(
      children: [
        SvgPicture.asset("assets/logo.svg"),
        Container(
          child: Mytext(
            text: "Главная",
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          margin: const EdgeInsets.only(top: 35)
        ),
        Container(
          child: SportTypesList(),
          margin: const EdgeInsets.only(
            top: 30
          ),
        ),
        Container(child: Text("text"),)
      ],
      isRight: true,
    );
  }
}