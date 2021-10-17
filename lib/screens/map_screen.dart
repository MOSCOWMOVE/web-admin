import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/sidbebar/RightSidebar.dart';
import 'package:moscow_move_mobile/components/sidbebar/leftSidebar.dart';
import 'package:moscow_move_mobile/components/map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RightSidebar(),
            LeftSidebar()
          ],
        ),
      ],
    );
  }
}