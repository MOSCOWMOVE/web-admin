import 'package:flutter/material.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class CustomScrollBar extends StatefulWidget {
  final BoxScrollView Function(ScrollController controller) builder;

  const CustomScrollBar({required this.builder, Key? key}) : super(key: key);

  @override
  _CustomScrollBarState createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  late ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      controller: controller,
      backgroundColor: Color(0xff5A5CD8),
      heightScrollThumb: 200,
      child: widget.builder(controller),
      scrollThumbBuilder: scrollThumbBuilder,
    );
  }

  Widget scrollThumbBuilder(
          Color backgroundColor,
          Animation<double> thumbAnimation,
          Animation<double> labelAnimation,
          double height,
          {BoxConstraints? labelConstraints,
          Text? labelText}) =>
      Container(
        color: backgroundColor,
        height: height,
        width: 12,
      );
}
