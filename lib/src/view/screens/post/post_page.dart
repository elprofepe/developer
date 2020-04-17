import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_profe/src/service/post_view_model.dart';
import 'package:el_profe/src/view/base/base_state.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:el_profe/src/view/widgets/preview_image_page.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:image/image.dart' as PI;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class PostPage extends StatefulWidget {

  PostPage({
    Key key,
    }) : super(key: key); 

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends BaseState<PostPage> {
  final GlobalKey<FormState> _formPostKey = GlobalKey<FormState>();
  List<File> _files = [];
  List<Widget> _widgetsFiles = [];
  final _documentController = TextEditingController();
  final documentFocus = FocusNode();
  TextInputType _typeInput = TextInputType.text;
  String _description = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>  Future.delayed(const Duration(seconds: 1), () => _settingModalBottomSheet(context)));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    resizeToAvoidBottomInset: false,
    resizeToAvoidBottomPadding: false,
    appBar: AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
        onPressed: () => Navigator.pop(context)
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Publicar',
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          onPressed: () => addPost(),
        )
      ],
      elevation: 0,
    ),
    body: SafeArea(
      child: Column(
        children: <Widget>[
        _files.isNotEmpty ?
        CarouselSlider(
            items: _widgetsFiles,
            height: (GContext.getHeight-120)/2,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          )
          : Image(
            image: AssetImage("assets/images/post_default.png"),
            fit: BoxFit.cover,
          ),
          Form(
            key: _formPostKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: _documentController,
                    focusNode: documentFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: _typeInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => {},
                    onSaved: (s) => _description = s,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Campo obligatorio.";
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 15.0,    
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: "Descripción",
                      hintText: "Descripción",
                      labelStyle: TextStyle(
                        color: grayTextForm
                      ), 
                      hintStyle: TextStyle(
                        color: grayTextForm
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: grayTextForm)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                    )
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () => _settingModalBottomSheet(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
              ),
              color: secondaryColor,
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Text(
                "Agregar foto",
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget itemFile(File file, int i) {
    return Stack(
      children: <Widget>[
        Container(
          width: (GContext.getWidth-60),
          height: (GContext.getHeight-120)/2,
          child: Image(
            image: FileImage(file),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top:0.0,
          right: 0.0,
          child: Container(
            color: secondaryColor,
            child: PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: white,
              ),
              onSelected: (index) async {
                switch (index) {
                  // case 0: print("cambiar");
                  //   break;
                  case 1: Navigator.push(context, MaterialPageRoute(builder: (contextB) => PreviewImage(photo: file)));
                    break;
                  case 2:  remove(i);
                  break;
                }
              },
              itemBuilder: (context) => [
                // PopupMenuItem<int>(
                //   value: 0,
                //   child: Text('Cambiar'),
                // ),
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
        ),
      ],
    );
  }

  addPost() {
    if (_formPostKey.currentState.validate()) {
      _formPostKey.currentState.save();
      showDialogLoading();
      PostViewModel.addPostStore(_description, _files).then((onValue) {
        hideDialog();
        print("-------------1-in-scaffold");
        print("${onValue[0]}");
        print("${onValue[1]}");
        if (onValue[0] == 0) {
          _success();
        } else {
          showDialogCustom(title: "Error", message: onValue[1]);
        }        
      });
    }
  }

  _success() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15.0),
              child: Text("Post agregado con existo"),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pop(context),
            }, 
            child: Text('Ok')
          )
        ],
      ),
    );
  }

  void remove(i) {
    print("delte");
    setState(() {
      _files.removeAt(i);
      if (_files.isEmpty) {
        _widgetsFiles = [];
      } else {
        _widgetsFiles = _files.asMap().entries.map((f) {
          return itemFile(
            f.value, f.key
          );
        }).toList();
      }
    });
    print("${_files.length}");
  }

  void _gallery() async{
    var gallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(10000);

    PI.Image image = PI.decodeImage(gallery.readAsBytesSync());
    PI.Image smallerImage = PI.copyResize(image, width: 1024);

    var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(PI.encodeJpg(smallerImage, quality: 75));
    
    setState(() {
      _files.add(compressedImage);
      _widgetsFiles = _files.asMap().entries.map((f) {
        return itemFile(
          f.value, f.key
        );
      }).toList();
    });
  }

  void _onImageButtonPressed(ImageSource source) async {    
    showDialogLoading();
    ImagePicker.pickImage(source: source, imageQuality: 75)
    .then((fileWithoutCompress) => _returnFileProcessed(fileWithoutCompress))
    .then((fileProcessed) {
      hideDialog();
      setState(() {
        _files.add(fileProcessed);
        _widgetsFiles = _files.asMap().entries.map((f) {
          return itemFile(
            f.value, f.key
          );
        }).toList();
      });
    }).catchError((e) {
      hideDialog();
      print("e => $e");
    });
  }

  Future<File> _returnFileProcessed(File file) async => await compute(_processImage, file);

  static File _processImage(File file) {
    PI.Image image = PI.decodeImage(file.readAsBytesSync());
    PI.Image resize = PI.copyResize(image, width: 1024);
    file..writeAsBytesSync(PI.encodeJpg(resize, quality: 75));
    return file;
  }
  
  void _settingModalBottomSheet(context){
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Galeria'),
                  onTap: () => {
                    Navigator.pop(context),
                    _gallery()
                  }          
                ),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camara'),
                  onTap: () => {
                    Navigator.pop(context),
                    _onImageButtonPressed(ImageSource.camera)
                  },          
                ),
                new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancelar'),
                  onTap: () => Navigator.pop(context)
                ),
              ],
            ),
          );
        }
      );
  }
}