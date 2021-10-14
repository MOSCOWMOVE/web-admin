import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double searchRowHeight = 40.0;

class SearchRow extends StatefulWidget {
  const SearchRow(
      {this.controller,
      this.onChanged,
      this.hintText,
      Key key})
      : super(key: key);

  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  _SearchRowState createState() => _SearchRowState();
}

class _SearchRowState extends State<SearchRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: searchRowHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
