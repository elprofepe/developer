import 'package:flutter/material.dart';
import 'package:el_profe/res/colors.dart';
import 'dart:io' show Platform;

class BottonNavBar extends StatefulWidget {
  final ValueSetter<int> select;
  final double width;
  final List<Map<String, Object>> list;

  BottonNavBar({
    this.select,
    this.width,
    this.list,
    Key key,
    }) : super(key: key);  

  @override
  _BottonNavBarState createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar> {
  int select = 0;
  bool typeNavSmall;
  List<Map<String, Object>> list;
  @override
  void initState() {
    typeNavSmall = (widget.width <= 300);
    list = widget.list;
    super.initState();
  }

  _listItem(bool tns, BuildContext context) {
  List<Widget> listButtons = List();
    for (var index = 0; index < list.length; index++) {
      listButtons.add(_itemNav(tns, index));
    }
    return listButtons;
  }

  _itemNav(bool tns, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () => onSelect(index),
          child: Container(
            height: tns ? 30.0 : 40.0,
            width: tns ? 30.0 : 40.0,
            child: Center(
              child: Icon(
                list[index]['icon'],
                color: select == index ? primaryColor : grayTextForm,
                size: tns ? 16.0 : 24.0,
              ),
            ),
          ),
        ),
        select == index ? Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            list[index]['name'],
            style: TextStyle(
              color: primaryColor,
              fontSize: 14.0
            ),
          ),
        ) : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 80.0 : 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 1.0,
            offset: Offset(0.0, -3.0),
          ),
        ]
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _listItem(typeNavSmall, context),
      ),
    );
  }

  onSelect(int i) {
    select = i;
    widget.select(i);
  }
}