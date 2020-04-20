import 'package:el_profe/src/model/user_model.dart';
import 'package:el_profe/src/service/user_view_model.dart';
import 'package:el_profe/src/view/base/base_state.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';

class SignInPage extends StatefulWidget {

  SignInPage({
    Key key,
    }) : super(key: key); 

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends BaseState<SignInPage> {
  final GlobalKey<FormState> _formSignInKey = GlobalKey<FormState>();

  final _documentController = TextEditingController();
  final _passwordController = TextEditingController();

  final documentFocus = FocusNode();
  final passwordFocus = FocusNode();
  String _email = "";
  String _password = "";
  bool passwordVisible = true;
  TextInputType _typeInput = TextInputType.text;
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    appBar: AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
        onPressed: () => Navigator.pop(context)
      ),
      elevation: 0,
    ),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 20.0),
            child: Text(
              'Ingresar',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Form(
            key: _formSignInKey,
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
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(passwordFocus),
                    onSaved: (s) => _email = s,
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
                      labelText: "Correo",
                      hintText: "Correo",
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.done,
                    maxLength: 20,
                    maxLines: 1,
                    onFieldSubmitted: (value) => _login(),
                    onSaved: (s) => _password = s,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Campo obligatorio.";
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 15.0,    
                    ),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      labelStyle: TextStyle(
                        color: grayTextForm
                      ), 
                      hintStyle: TextStyle(
                        color: grayTextForm
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: grayTextForm)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: grayTextForm,
                          ),
                        onPressed: () {
                          setState(() {
                              passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
           Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: RaisedButton(
              onPressed: () => _login(),
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
         ],
      ),
    ),
  );

  _login() {
    if (_formSignInKey.currentState.validate()) {
      _formSignInKey.currentState.save();
      showDialogLoading();
      User user = User(email: _email, password: _password);
      UserViewModel.userLogin(user).then((response){
        hideDialog();
        if (response[0] == 0) {
          GContext.setsetUser(response[1]);
          Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
        } else {
          showDialogCustom(title: "Error", message: response[1]);
        }
      });
    }
  }
}