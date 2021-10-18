// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moscow_move_mobile/components/CheckBox.dart';
import 'package:moscow_move_mobile/components/DropDownLists/DropDownList.dart';
import 'package:moscow_move_mobile/components/Input.dart';

class DiscritList extends StatelessWidget {
  const DiscritList({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDownList(
      content: [
        Input(),
        DropDownList(
          content: [
            MyCheckBox(text: "Центральный",)
          ],
        )
      ],
    );
  }
}