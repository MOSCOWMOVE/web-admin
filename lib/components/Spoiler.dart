// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import "dart:math";

import 'package:moscow_move_mobile/components/Text.dart';

class Spoiler extends StatefulWidget {
  Spoiler({ Key key, this.child, this.name }) : super(key: key);

  Widget child;
  String name;

  @override
  _SpoilerState createState() => _SpoilerState();
}

class _SpoilerState extends State<Spoiler> with SingleTickerProviderStateMixin {
  
  AnimationController animation;
  bool isActive = false;

  void initState() {
    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))..addListener(
      () { 
        setState((){});
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (animation.value == 1) {
              animation.animateBack(0);
              Timer(Duration(milliseconds: 200), () {
                setState(() {
                  isActive=false;
                });
              });
              
            }
            else {
              setState((){isActive=true;});
              animation.animateTo(1);
            }
          },
          child: Row(
            children: [
              Transform.rotate(
                angle: 1.5 * pi * animation.value,
                child: SvgPicture.asset("assets/spoiler_icon.svg"),
              ),
              Container(width: 5),
              SizedBox(
                child: Mytext(
                  centered: false,
                  text: widget.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff23245C),
                ),
                width: 180
              ),
              
            ],
          ),
        ),
        Container(height: 10,),
        (isActive ? Container( 
          child: ScaleTransition(
            child: widget.child,
            scale: animation
          ),
        ) : Container())
        
      ],
    );
  }
}