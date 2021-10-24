// ignore_for_file: file_names

import 'dart:convert';
import 'dart:html';

import 'package:localstorage/localstorage.dart';

class Point{
  Point({this.id, this.cords, this.type, this.area});
  
  String id;
  List<double> cords;
  int type;
  double area;
}

void SetPoints(List<Point> points) {
  LocalStorage storage = new LocalStorage('localstorage_app');
  dynamic jsonPoints = points.map((point) {
    return {
      "id": point.id,
      "cords": point.cords,
      "type": point.type,
      "amount": "1",
      "area": point.area,
    };
  }).toList();

  dynamic dots = { 
    "markers" : []
  };
  dots["markers"] = jsonPoints;
  var iframe = (window.document.getElementById("map_widget") as IFrameElement).contentWindow;
  iframe.postMessage(dots, "*");

  storage.setItem("dots", jsonEncode(dots));
} 