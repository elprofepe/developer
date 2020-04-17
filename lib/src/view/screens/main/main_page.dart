import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';

class MainPage extends StatefulWidget {

  MainPage({
    Key key,
    }) : super(key: key); 

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with GContext {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Center(
              child: Image(
                width: (GContext.getWidth/2) + 40.0,
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'EL PROFESOR',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(
            'Le damos solución a tus problemas'
          ),
          Expanded(child: Container()),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: RaisedButton(
              onPressed: () => _openRoute('/sign/in'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: primaryColor,
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Text(
                "Ingresar",
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            child: OutlineButton(
              onPressed: () => _openRoute('/sign/up'),
              borderSide: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Text(
                "Registrarse",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
            child: RaisedButton(
              onPressed: () => _openRoute('/postulant'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: secondaryColor,
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Text(
                "Postular",
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

  _openRoute(String name) => Navigator.pushNamed(context, name);
  
}