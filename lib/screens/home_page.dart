import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/truffel/ckuicq7980ure17q1ydrzbn8c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidHJ1ZmZlbCIsImEiOiJja3VpY2kxdzcxZWo3MnBudjl0Z2w2c3hmIn0.ZqXo76bTm51a7n2wPoMVuA",
            additionalOptions: {
              'accessToken':'pk.eyJ1IjoidHJ1ZmZlbCIsImEiOiJja3VpY2kxdzcxZWo3MnBudjl0Z2w2c3hmIn0.ZqXo76bTm51a7n2wPoMVuA',
              'id': 'mapbox.mapbox-streets-v8'
            }
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) =>
                    Container(
                      child: FlutterLogo(),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
