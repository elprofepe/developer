import 'package:el_profe/src/model/teacher_model.dart';
import 'package:el_profe/src/service/teacher_view_model.dart';
import 'package:el_profe/src/view/base/base_state.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';

class PostulantPage extends StatefulWidget {

  PostulantPage({
    Key key,
    }) : super(key: key); 

  @override
  _PostulantPageState createState() => _PostulantPageState();
}

class _PostulantPageState extends BaseState<PostulantPage> {
  final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _documentController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final documentFocus = FocusNode();

  String _name = "";
  String _email = "";
  String _phone = "";
  String _document = "";

  TextInputType _typeInput = TextInputType.text;
  TextInputType _phoneInput = TextInputType.phone;
  TextInputType _numberInput = TextInputType.number;
  
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
              'Postular',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Form(
            key: _formSignUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: _nameController,
                    focusNode: nameFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: _typeInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(emailFocus),
                    onSaved: (s) => _name = s,
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
                      labelText: "Nombre",
                      hintText: "Nombre",
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
                    controller: _emailController,
                    focusNode: emailFocus,
                    textInputAction: TextInputAction.done,
                    keyboardType: _typeInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(phoneFocus),
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
                    controller: _phoneController,
                    focusNode: phoneFocus,
                    textInputAction: TextInputAction.done,
                    keyboardType: _phoneInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(documentFocus),
                    onSaved: (s) => _phone = s,
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
                      labelText: "Celular",
                      hintText: "Celular",
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
                    controller: _documentController,
                    focusNode: documentFocus,
                    textInputAction: TextInputAction.done,
                    keyboardType: _numberInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => _register(),
                    onSaved: (s) => _document = s,
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
                      labelText: "Documento",
                      hintText: "Documento",
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: RaisedButton(
              onPressed: () => _register(),
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

  
  _register() {
    if (_formSignUpKey.currentState.validate()) {
      _formSignUpKey.currentState.save();
      showDialogLoading();
      Teacher teacher = Teacher(
        document: _document,
        email: _email,
        isAttention: false,
        name: _name,
        phone: _phone,
      );
      PostulantViewModel.setPostulantData(teacher).then((response){
        hideDialog();
        if (response[0] == 0) {
          showDialogCustom(title: "Atención", message: response[1]);
        } else {
          showDialogCustom(title: "Error", message: response[1]);
        }
      });
    }
  }
}