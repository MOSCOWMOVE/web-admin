// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:moscow_move_mobile/components/Text.dart';

class MyCheckBox extends StatefulWidget {
  MyCheckBox({ Key key, this.text, this.fontWeight }) : super(key: key);

  String text;
  FontWeight fontWeight;

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> with SingleTickerProviderStateMixin{

  bool active = false;

  AnimationController controller;
  Animation<double> animation;

  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 50), vsync: this)
    ..addListener(() {
      setState(() {});
     });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: GestureDetector(
        
        onTap: () {
          setState(() {
            if (controller.value == 1) {
              controller.animateBack(0);
            }
            else{
              controller.animateTo(1);
            }
          });
        },
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xffABABDB),
                  ),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: ScaleTransition(
                  scale: controller,
                  child: SvgPicture.asset("assets/check.svg"),
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 11
              ),
              child: Mytext(
                text: widget.text,
                fontWeight: widget.fontWeight,
                fontSize: 14,
              )
            ),
          ],
        ) 
      )
    );
  }
}