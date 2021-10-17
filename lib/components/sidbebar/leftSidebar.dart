// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/sidbebar/BaseSidebar.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;


    return BaseSidebar(
      children: [],
      isRight: false,
    );
  }
}