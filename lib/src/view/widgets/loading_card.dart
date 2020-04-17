import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  
  final EdgeInsetsGeometry margin;

  LoadingCard({
    this.margin = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
    Key key,
    }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      elevation: 1,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade600,
        child: Container(
          height: (GContext.getWidth - 45)/2,
          width: (GContext.getWidth - 90),
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                height: (GContext.getWidth - 160)/2,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}