import 'package:flutter/material.dart';

class CategoriesDrawer extends StatefulWidget {
  const CategoriesDrawer({this.items, Key key}) : super(key: key);

  final List<Widget> items;

  @override
  _CategoriesDrawerState createState() => _CategoriesDrawerState();
}

class _CategoriesDrawerState extends State<CategoriesDrawer> {
  final _padding = EdgeInsets.symmetric(horizontal: 25.0, vertical: 60.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: _padding,
          children: widget.items,
        ),
      ),
    );
  }
}
