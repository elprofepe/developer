import 'dart:io';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:el_profe/res/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FileManager extends StatefulWidget {
  final ValueSetter<int> select;
  final File imageFile;
  final int position;

  FileManager({
    this.select,
    this.imageFile,
    this.position,
    Key key,
    }) : super(key: key);  

  @override
  _FileManagerState createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: (GContext.getWidth-60),
          height: (GContext.getHeight-120)/2,
          child: Image(
            image: FileImage(widget.imageFile),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: secondaryColor,
          child: PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: white,
            ),
            onSelected: (index) async {
              switch (index) {
                case 0: print("cambiar");
                  break;
                case 1: print("preview");
                  break;
                case 2: print("borrar");
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Cambiar'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Preview completa'),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text('borrar'),
              ),
            ],
          ),
        )
      ],
    );
  }
}