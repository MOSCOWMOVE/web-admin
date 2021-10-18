// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/Input.dart';
import 'package:moscow_move_mobile/components/ScrollWidget.dart';

import 'DropDownList.dart';

class BaseFilterDropDownList extends StatefulWidget {
  BaseFilterDropDownList({ Key key, this.name, this.checkboxes }) : super(key: key);
  
  String name;
  List<String> checkboxes;

  @override
  _BaseFilterDropDownListState createState() => _BaseFilterDropDownListState();
}

class _BaseFilterDropDownListState extends State<BaseFilterDropDownList> {
  @override
  Widget build(BuildContext context) {
    return DropDownList(
      content: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Input()
        ),
        Container(
          margin: EdgeInsets.only(top:18),
          child: ScrollWidget(
            // ignore: unnecessary_cast
            children: ([
              Container(),
              MyCheckBox(text: "Выделить все", fontWeight: FontWeight.w700),
            ] as List<Widget>) + widget.checkboxes.map((e) =>
                Container(
                  child: MyCheckBox(text: e, fontWeight: FontWeight.w600,),
                  margin: const EdgeInsets.only(top:18),
                )
            ).toList()
          )
        ),
        
      ],
      open: false,
      name: widget.name
    );
  }
}