// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  ScrollWidget({ Key key, this.children }) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return children[index];
            },
            childCount: children.length
          )
        )
      ],
    
    );
  }
}