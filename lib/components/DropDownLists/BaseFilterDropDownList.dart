// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/Input.dart';
import 'package:moscow_move_mobile/components/ScrollWidget.dart';
import 'package:moscow_move_mobile/components/Text.dart';

import 'DropDownList.dart';

class BaseFilterDropDownList extends StatefulWidget {
  BaseFilterDropDownList({ Key key, this.name, this.checkboxes, this.onChange }) : super(key: key);
  
  String name;
  List<String> checkboxes;
  Function onChange;

  @override
  _BaseFilterDropDownListState createState() => _BaseFilterDropDownListState();
}

class _BaseFilterDropDownListState extends State<BaseFilterDropDownList> {

  List<String> selected = [];

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
            child: ListView.builder(
              itemCount: widget.checkboxes.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MyCheckBox(text: "Выделить все", fontWeight: FontWeight.w700, selected: false,);
                }
                index = index -1;
                return Container(
                  margin: EdgeInsets.only(top: 18),
                  child: MyCheckBox(text: widget.checkboxes[index], 
                    fontWeight: FontWeight.w600, 
                    selected: selected.contains(widget.checkboxes[index]),
                    onChange: (bool isSelected) {
                      if (isSelected) {
                        selected.add(widget.checkboxes[index]);
                        widget.onChange(selected);
                      } else {
                        selected.remove(widget.checkboxes[index]);
                        widget.onChange(selected);
                      }
                    },
                  )
                );
              },
            )
          )
        ),
        
      ],
      open: false,
      name: widget.name
    );
  }
}


/*
([
              Container(),
              MyCheckBox(text: "Выделить все", fontWeight: FontWeight.w700, selected: false,),
            ] as List<Widget>) + widget.checkboxes.map((e) =>
                Container(
                  child: MyCheckBox(text: e, fontWeight: FontWeight.w600, onChange: (bool isSelected) {
                    if (isSelected) {
                      selected.add(e);
                      widget.onChange(selected);
                    } else {
                      selected.remove(e);
                      widget.onChange(selected);
                    }
                  }, selected: selected.contains(e),),
                  margin: const EdgeInsets.only(top:18),
                )
            ).toList()*/