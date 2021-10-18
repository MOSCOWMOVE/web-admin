// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  ScrollWidget({ Key key, this.children }) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
      child:  SizedBox(
        height: 200,
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: children
        )
      )
    );
  }
}