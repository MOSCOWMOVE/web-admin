// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/Input.dart';
import 'package:moscow_move_mobile/components/ScrollWidget.dart';
import 'package:moscow_move_mobile/components/Text.dart';
import 'package:moscow_move_mobile/components/sidbebar/leftSidebar.dart';

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
  bool all_selected = false;

  String filter = "";

  @override
  Widget build(BuildContext context) {

    List<String> filtered = widget.checkboxes;
    if (filter.isNotEmpty) {
      filtered = filtered.where((e) => e.contains(filter)).toList();
    }

    return DropDownList(
      content: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Input(onChange: (String e) {
            setState(() {
              filter = e;
            });
          },)
        ),
        Container(
          margin: EdgeInsets.only(top:18),
          child: ScrollWidget(
            // ignore: unnecessary_cast
            child: ListView.builder(
              
              itemCount: filtered.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MyCheckBox(length_dep: 20, text: "Выделить все", fontWeight: FontWeight.w700, selected: all_selected, onChange: (sel) {
                    if (sel) {
                      setState(() {
                        selected = widget.checkboxes;
                      });
                      
                      widget.onChange(["__all__"]);
                    }
                    all_selected = sel;
                  },);
                }
                index = index -1;
                return Container(
                  key: UniqueKey(),
                  margin: EdgeInsets.only(top: 18),
                  child: MyCheckBox(
                    text: filtered[index], 
                    length_dep: 20,
                    fontWeight: FontWeight.w600, 
                    selected: this.selected.contains(filtered[index]),
                    onChange: (bool isSelected) {
                      if (isSelected) {
                        selected.add(filtered[index]);
                        widget.onChange(selected);
                      } else {
                        selected.remove(filtered[index]);
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


