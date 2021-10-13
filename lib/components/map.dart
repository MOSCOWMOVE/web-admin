import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;




class MapWidget extends StatelessWidget {
  const MapWidget({  Key ?key }) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'map',
            (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'lib/components/assets/index.html'
          ..style.border = 'none');
    return
      Scaffold(
      body: HtmlElementView(viewType: "map",)
      );

  }
}