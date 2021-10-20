// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  ScrollWidget({ Key key, this.child }) : super(key: key);

  List<Widget> children;
  ListView child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
      child:  SizedBox(
        height: 200,
        child: child
      )
    );
  }
}