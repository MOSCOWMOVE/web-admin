// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moscow_move_mobile/components/Text.dart';
import "dart:math";
import 'package:animated_overflow/animated_overflow.dart';


// ignore: must_be_immutable
class DropDownList extends StatefulWidget {
  DropDownList({ Key key, this.open, this.content, this.name }) : super(key: key);

  bool open;
  List<Widget> content;
  String name;

  @override
  // ignore: no_logic_in_create_state
  _DropDownListState createState() => _DropDownListState(open: open);
}

class _DropDownListState extends State<DropDownList> with SingleTickerProviderStateMixin {
  
  _DropDownListState({this.open}) : super();

  bool open = false;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
    ..addListener(() { setState(() {
      
    });});
  }

  @override
  Widget build(BuildContext context) {


    // ignore: avoid_unnecessary_containers
    return Container(
      child: GestureDetector(
        
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (open == false) {
                  controller.animateTo(1);
                  setState(() {open = true;});
                }
                else {
                  controller.animateTo(0);
                  Timer(
                    const Duration(milliseconds: 200), 
                    () {
                      setState(() {open = false;});
                    });
                }
              },
              child: Row(
                children: [
                  Mytext(
                    fontWeight: FontWeight.w700, 
                    text: widget.name, 
                    fontSize: 16
                  ),
                  Container(
                    child: Transform.rotate(
                      child: SvgPicture.asset("assets/arrow.svg"),
                      angle: controller.value * pi
                    ),
                    margin: const EdgeInsets.only(left: 7)
                  ),
                ],
              ),
            ),
            
            open ? 
            ScaleTransition(
              scale: controller,
              child: Column(children: widget.content,),
            ) : Container()
          ]
        )
      )
    );
  }
}