import 'package:el_profe/src/view/widgets/loading_card.dart';
import 'package:flutter/material.dart' hide Colors;

class ColumnLoadingCard extends StatelessWidget {
  
  ColumnLoadingCard({
    Key key,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LoadingCard(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
        LoadingCard(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
        LoadingCard(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ],
    );
  }
}