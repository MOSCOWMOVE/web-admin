import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/screens/map_screen.dart';
import 'package:moscow_move_mobile/PointOperations.dart';
import 'components/map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'PointOperations.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(const Color(0xffABABDB)),
            isAlwaysShown: true,
            thickness: MaterialStateProperty.all(4)
          ),
          primarySwatch: Colors.blue,
          fontFamily: "Averta CY"
        ),
        home: const Scaffold(
          body: MapScreen(),
        ),
      );
  }
}

