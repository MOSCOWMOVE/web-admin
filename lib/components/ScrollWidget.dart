// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  ScrollWidget({ Key key, this.children }) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(  
        children: children
      )
    );
  }
}