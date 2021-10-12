// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';


class MainMap extends StatefulWidget {
  const MainMap();
  @override
  State<StatefulWidget> createState() => MainMapState();
}

class MainMapState extends State<MainMap>{
  MainMapState();
    static final LatLng center = const LatLng(-33.86711, 151.1947171);
    static const String ACCESS_TOKEN = "pk.eyJ1IjoiZmlyZXNpZWh0IiwiYSI6ImNrdW9kemYzbTB4ZGkycHAxbXN2YnIzaGMifQ.G0fl-qVbecucfOvn8OtU4Q";
    MapboxMapController? controller;
    Symbol? _selectedSymbol;


    void _onMapCreated(MapboxMapController controller) {
      this.controller = controller;
      controller.onSymbolTapped.add(_onSymbolTapped);
      
      for (int i = 1; i < 9; i++){
        LatLng geometry = LatLng(
          center.latitude + i,
          center.longitude + i,
        );
        _add(geometry);

        }
      }


  void _updateSelectedSymbol(SymbolOptions changes) {
    controller!.updateSymbol(_selectedSymbol!, changes);
  }

    void _onSymbolTapped(Symbol symbol) {
      if (_selectedSymbol != null) {
        _updateSelectedSymbol(
          const SymbolOptions(iconSize: 1.0),
        );
      }
      setState(() {
        _selectedSymbol = symbol;
      });
      _updateSelectedSymbol(
        SymbolOptions(
          iconSize: 1.4,
        ),
      );
    }

     void _add(LatLng geometry) {
      List<int> availableNumbers = Iterable<int>.generate(12).toList();
        controller!.symbols.forEach(
            (s) => availableNumbers.removeWhere((i) => i == s.data!['count']));
        if (availableNumbers.isNotEmpty) {
          controller!.addSymbol(
              SymbolOptions(
                geometry: geometry,
                iconImage: 'airport-15',
            )
          );
        }
      }
    void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/symbols/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

    Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return controller!.addImage(name, response.bodyBytes);
  }

    void _removeAll() {
    controller!.removeSymbols(controller!.symbols);
    setState(() {
      _selectedSymbol = null;
    });
  } //удаление объектов с карты

  Widget build(BuildContext context) {
    return SizedBox(
            width: 300.0,
            height: 200.0, 
            child: MapboxMap(
              accessToken: ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: _onStyleLoaded,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-33.852, 151.211),
                zoom: 11.0,
              ),
            ),
          );
  }

}