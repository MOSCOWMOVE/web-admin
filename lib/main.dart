import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/screens/map_screen.dart';
import 'components/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Averta CY"
      ),
      home: Scaffold(
        body: MapScreen(),
      ),
    );
  }
}

