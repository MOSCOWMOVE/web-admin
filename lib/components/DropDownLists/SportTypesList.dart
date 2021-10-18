// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/DropDownLists/DropDownList.dart';
import 'package:moscow_move_mobile/components/Input.dart';
import 'package:moscow_move_mobile/components/ScrollWidget.dart';
import 'package:moscow_move_mobile/components/Text.dart';



class SportTypesList extends StatefulWidget {
  const SportTypesList({ Key key }) : super(key: key);

  @override
  _SportTypesListState createState() => _SportTypesListState();
}

class _SportTypesListState extends State<SportTypesList> {
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
            children: [
              MyCheckBox(text: "Выделить все", fontWeight: FontWeight.w700),
              const SizedBox(height: 18,),
              MyCheckBox(text: "Футбол", fontWeight: FontWeight.w600),
              const SizedBox(height: 18,),
              MyCheckBox(text: "Футбол", fontWeight: FontWeight.w600),
              const SizedBox(height: 18,),
              MyCheckBox(text: "Футбол", fontWeight: FontWeight.w600)
            ],
          )
        ),
        
      ],
      open: false,
      name: "Виды спорта"
    );
  }
}