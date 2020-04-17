import 'package:cached_network_image/cached_network_image.dart';
import 'package:el_profe/src/model/post_model.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';

class ItemHomeFragment extends StatefulWidget {
  final bool isFirst;
  final Post post;

  ItemHomeFragment({
    this.isFirst,
    this.post,
    Key key,
    }) : super(key: key); 

  @override
  _ItemHomeFragmentState createState() => _ItemHomeFragmentState();
}

class _ItemHomeFragmentState extends State<ItemHomeFragment> with GContext {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        !widget.isFirst ? Container(
          width: double.infinity,
          height: 1.0,
          margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          color: grayTextForm,
        ) : Container(),
        Row(
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.post.author.toUpperCase().substring(0, 1),
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            // Container(
            //   child: CachedNetworkImage(
            //     imageUrl: "https://firebasestorage.googleapis.com/v0/b/profesor-4afb3.appspot.com/o/users%${widget.post.uid}.png?alt=media&token=ce1527b4-be60-4759-9dde-8a2d1b24aa2b",
            //     imageBuilder: (context, imageProvider) => Container(
            //       height: 50.0,
            //       width: 50.0,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         image: DecorationImage(
            //             image: imageProvider,
            //             fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //     placeholder: (context, url) => Container(
            //       height: 50.0,
            //       width: 50.0,
            //       decoration: BoxDecoration(
            //         color: primaryColor,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Center(
            //         child: Icon(
            //           Icons.person,
            //           size: 24.0,
            //           color: white
            //         ),
            //       ),
            //     ),
            //     errorWidget: (context, url, error) => Container(
            //       height: 50.0,
            //       width: 50.0,
            //       decoration: BoxDecoration(
            //         color: primaryColor,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Center(
            //         child: Icon(
            //           Icons.person,
            //           size: 24.0,
            //           color: white
            //         ),
            //       ),
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.post.author
                  ),
                  Text(
                    widget.post.timePast
                  ),
                ],
              )
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(60.0, 10.0, 0.0, 10.0),
          child: CachedNetworkImage(
            imageUrl: widget.post.imageUrls.first,
            imageBuilder: (context, imageProvider) => Container(
              height: (GContext.getWidth - 45)/2,
              width: (GContext.getWidth - 90),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => progressDefault(40.0),
            errorWidget: (context, url, error) => Image(
              image: AssetImage("assets/images/post_default.png"),
              fit: BoxFit.contain,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ],
    )
  );

  Widget progressDefault(size) => Container(
    height: size,
    width: size,
    child: CircularProgressIndicator(),
  );
}