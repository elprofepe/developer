import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart' hide Colors;
import 'package:el_profe/res/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';
class PreviewImage extends StatelessWidget {
  final File photo;
  final String path;

  PreviewImage({
    this.photo,
    this.path = ""
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text(
          'Preview',
          style: TextStyle(
            color: white
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
          onPressed: () => Navigator.pop(context)
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Hero(
            tag: "hero1",
            child: Container(
              child: PhotoView(
                imageProvider: path.isNotEmpty ?
                AdvancedNetworkImage(
                  photo.path,
                  useDiskCache: false
                ) :  
                ExactAssetImage(
                  photo.path
                )
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget progressDefault(size) => Container(
    height: size,
    width: size,
    child: CircularProgressIndicator(),
  );
}