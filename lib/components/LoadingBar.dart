// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff23245C),
          width: 1
        )
      ),
      child: Container(
        color: Color(0xff),
      )
    );
  }
}