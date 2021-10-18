// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;


// ignore: must_be_immutable
class BaseSidebar extends StatelessWidget {
  BaseSidebar({ Key key, this.children, this.isRight }) : super(key: key);

  List<Widget> children;
  bool isRight;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var body = html.window.document.getElementById("body");
    body.style.cursor = "pointer!important;";
    return MouseRegion(
      onHover: (e) => {
        body.style.cursor = "pointer!important;"
      },
      child: Container(
        height: height,
        width: 277,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: !this.isRight ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20)
          ) : const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          boxShadow: const [
              BoxShadow(
              color: Color.fromRGBO(0,0,0,0.12),
              blurRadius: 20,
              spreadRadius: 0
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(47),
          child: OverflowBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.children
            )
            
          )
        )
      )
    );
  }
}