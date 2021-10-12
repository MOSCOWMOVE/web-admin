import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

List<String> kindsOfSport = [
  'Выделить всё',
  'Футбол',
  'Волейбол',
  'Баскетбол',
  'Плавание'
];

class DropDownList extends StatefulWidget {
  const DropDownList({this.opened = false, Key? key}) : super(key: key);

  final bool opened;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> with SingleTickerProviderStateMixin {

  double chevronRotationAngle = -pi * 0.5;
  late bool DropDownListOpened;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DropDownListOpened = widget.opened;
  }

  void onChevronTap() {
    setState(() {
      if (!DropDownListOpened) {
        chevronRotationAngle = -pi * 0.5;
      } else {
        chevronRotationAngle = pi * 0.5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Виды спорта'),
          trailing: Transform.rotate(
            angle: chevronRotationAngle,
            child: Icon(Icons.chevron_left),
          ),
          onTap: () {
            setState(() {
              DropDownListOpened = !DropDownListOpened;
              onChevronTap();
            });
          },
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 700),
          vsync: this,
          child: SizedBox(
            height: DropDownListOpened ? 250 : 0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: kindsOfSport.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('${kindsOfSport[index]}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
