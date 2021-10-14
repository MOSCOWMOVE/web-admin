import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moscow_move_mobile/components/categories_drawer.dart';
import 'package:moscow_move_mobile/components/drop_down_list.dart';
import 'package:moscow_move_mobile/components/search_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnimationController chevronAnimationController;
  TextEditingController _searchRowController = TextEditingController();
  bool DropDownListOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CategoriesDrawer(
        items: [
          SizedBox(height: 30),
          Text(
            'Главная',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          DropDownList(),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/truffel/ckuicq7980ure17q1ydrzbn8c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidHJ1ZmZlbCIsImEiOiJja3VpY2kxdzcxZWo3MnBudjl0Z2w2c3hmIn0.ZqXo76bTm51a7n2wPoMVuA",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoidHJ1ZmZlbCIsImEiOiJja3VpY2kxdzcxZWo3MnBudjl0Z2w2c3hmIn0.ZqXo76bTm51a7n2wPoMVuA',
                      'id': 'mapbox.mapbox-streets-v8'
                    }),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.5, -0.09),
                      builder: (ctx) => Container(
                        child: FlutterLogo(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onDropDownListTap() {
    setState(() {
      DropDownListOpened = !DropDownListOpened;
    });
  }
}
