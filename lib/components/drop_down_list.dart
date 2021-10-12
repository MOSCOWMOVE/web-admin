import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:moscow_move_mobile/components/custom_scroll_bar.dart';
import 'package:moscow_move_mobile/components/search_row.dart';
import 'package:moscow_move_mobile/models/sport_checkbox_state.dart';

final pickEverySport = SportCheckBoxState(title: 'Выбрать всё');

final listOfSport = [
  SportCheckBoxState(title: 'Футбол'),
  SportCheckBoxState(title: 'Волейбол'),
  SportCheckBoxState(title: 'Баскетбол'),
  SportCheckBoxState(title: 'Плавание'),
];

class DropDownList extends StatefulWidget {
  const DropDownList({this.opened = false, Key? key}) : super(key: key);

  final bool opened;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList>
    with SingleTickerProviderStateMixin {
  double chevronRotationAngle = -pi * 0.5;
  late bool DropDownListOpened;
  TextEditingController _searchRowController = TextEditingController();

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
            child: CustomScrollBar(
              builder: (controller) => ListView(
                controller: controller,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: SearchRow(
                        controller: _searchRowController,
                        onChanged: (text) {},
                        hintText: 'Найти...'),
                  ),
                  _buildGroupSportItem(pickEverySport),
                  ...listOfSport.map((item) => _buildSportItem(item)).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSportItem(SportCheckBoxState item) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: item.value,
        title: Text(item.title),
        onChanged: (value) => setState(() {
              item.value = value!;
              pickEverySport.value =
                  listOfSport.every((element) => element.value);
            }));
  }

  Widget _buildGroupSportItem(SportCheckBoxState item) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: item.value,
        title: Text(item.title),
        onChanged: (value) => setState(() {
              item.value = value!;
              listOfSport.forEach((element) {
                element.value = value;
              });
            }));
  }

  // List<Widget> _buildListOfSport() {
  //   var list = listOfSport
  //       .map((item) => CheckboxListTile(
  //           controlAffinity: ListTileControlAffinity.leading,
  //           value: item.value,
  //           title: Text(item.title),
  //           onChanged: (value) => setState(() {
  //                 item.value = value!;
  //               })))
  //       .toList();
  //   return list;
  // }
}
