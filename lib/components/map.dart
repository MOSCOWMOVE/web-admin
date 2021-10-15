import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';



class MapWidget extends StatelessWidget {
  MapWidget({  Key key }) : super(key: key);  
  
  
  LocalStorage storage = new LocalStorage('localstorage_app');


  var dots = { 
    "markers" : [
        {

            "id" : 1001,
            "cords" : [37.65, 55.88],
            "type" : 500,
            "amount" : 2
        },
        {
            "id" : 1002,
            "cords": [37.55, 55.75],
            "type": 1000,
            "amount": 5
        },
        {
            "id" : 1003,
            "cords":  [37.80, 55.69],
            "type": 3000,
            "amount": 7
        },
        {
            "id" : 1004,
            "cords":  [37.47, 55.86],
            "type": 5000,
            "amount": 10
        }

        ]
    };
  

  
  @override
  Widget build(BuildContext context) {
    html.window.localStorage['dots'] = jsonEncode(dots);
    html.window.localStorage['blackTheme'] = 'false';
    html.window.addEventListener('storage', (e) => {
            print( html.window.localStorage['activePoint'])

    } );
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'map',
            (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'lib/components/assets/dist/index.html'
          ..style.border = 'none');
    return
      Scaffold(
      body: HtmlElementView(viewType: "map",)
      );

  }
}