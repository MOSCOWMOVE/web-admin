import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:moscow_move_mobile/components/custom_scroll_bar.dart';
import 'package:moscow_move_mobile/components/search_row.dart';
import 'package:moscow_move_mobile/models/sport_checkbox_state.dart';


class DropDownList extends StatefulWidget {
  const DropDownList({required this.title, required this.masterItemTitle,required this.itemsTitles, this.opened = false, Key? key}) : super(key: key);

  final List<String> itemsTitles;
  final String masterItemTitle;
  final String title;
  final bool opened;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList>
    with SingleTickerProviderStateMixin {
  double chevronRotationAngle = -pi * 0.5;
  late bool DropDownListOpened;
  TextEditingController _searchRowController = TextEditingController();
  late List<SportCheckBoxState> listOfItems;
  late SportCheckBoxState masterItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DropDownListOpened = widget.opened;
    listOfItems = widget.itemsTitles.map((title) => SportCheckBoxState(title: title)).toList();
    masterItem = SportCheckBoxState(title: widget.masterItemTitle);
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
          title: Text(widget.title),
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
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  child: SearchRow(
                      controller: _searchRowController,
                      onChanged: (text) {},
                      hintText: 'Найти...'),
                ),
                _buildGroupSportItem(masterItem),
                ...listOfItems.map((item) => _buildSportItem(item)).toList(),
              ],
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
              masterItem.value =
                  listOfItems.every((element) => element.value);
            }));
  }

  Widget _buildGroupSportItem(SportCheckBoxState item) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: item.value,
        title: Text(item.title),
        onChanged: (value) => setState(() {
              item.value = value!;
              listOfItems.forEach((element) {
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
