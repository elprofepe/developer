import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final VoidCallback action;
  final String errorMessage;
  final Color colorTB;

  ErrorMessage({
    this.action,
    this.errorMessage = "", 
    this.colorTB = Colors.white,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorTB,
                fontSize: 16.0
              ),
            ),
          ),
          IconButton(
            onPressed: () => action(),
            icon: Icon(
              Icons.refresh,
              color: colorTB,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}