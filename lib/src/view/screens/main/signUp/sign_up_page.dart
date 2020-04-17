import 'package:el_profe/src/model/user_model.dart';
import 'package:el_profe/src/service/user_view_model.dart';
import 'package:el_profe/src/view/base/base_state.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
class SignUpPage extends StatefulWidget {

  SignUpPage({
    Key key,
    }) : super(key: key); 

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseState<SignUpPage> {
  final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final nameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  String _name = "";
  String _lastName = "";
  String _birthDay = "";
  String _email = "";
  String _password = "";

  bool passwordVisible = true;
  TextInputType _typeInput = TextInputType.text;
  
  String MIN_DATETIME = '2010-05-12';
  String MAX_DATETIME = '2021-11-25';
  String INIT_DATETIME = '2019-05-17';
  bool _showTitle = true;
  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime maxDate = DateTime((now.year - 5));
    DateTime minDate = DateTime((now.year - 99));

    MIN_DATETIME = DateFormat("yyyy-MM-dd").format(minDate);
    MAX_DATETIME = DateFormat("yyyy-MM-dd").format(maxDate);
    INIT_DATETIME = DateFormat("yyyy-MM-dd").format(maxDate);
    _dateTime = DateTime.parse(INIT_DATETIME);
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
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 20.0),
            child: Text(
              'Crear Usuario',
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
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(lastNameFocus),
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
                    controller: _lastNameController,
                    focusNode: lastNameFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: _typeInput,
                    maxLines: 1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(emailFocus),
                    onSaved: (s) => _lastName = s,
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
                      labelText: "Apellido",
                      hintText: "Apellido",
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
                  child: InkWell(
                    onTap: () => _showDatePicker(),
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: _formatCtrl,
                        maxLines: 1,
                        onSaved: (value) => _birthDay = value,
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
                          labelText: "Fecha de Nacimiento",
                          hintText: "Fecha de Nacimiento",
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
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: _emailController,
                    focusNode: emailFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: _typeInput,
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
                    onFieldSubmitted: (value) => _register(),
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
            child: OutlineButton(
              onPressed: () => _register(),
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
         ],
      ),
    ),
  );
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('Ok', style: TextStyle(color: secondaryColor)),
        cancel: Text('Cancelar', style: TextStyle(color: grayTextForm)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: DateTimePickerLocale.es,
      onClose: () => print("onClose"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          _formatCtrl.text = DateFormat("yyyy-MM-dd").format(_dateTime);
        });
      },
    );
  }

  _register() {
    if (_formSignUpKey.currentState.validate()) {
      _formSignUpKey.currentState.save();
      showDialogLoading();
      User user = User(
        email: _email, 
        password: _password, 
        name: _name, 
        lastName: _lastName,
        birthdate: _formatCtrl.text,
        document: "",
        isValidEmail: true,
        gender: "",
        uid: "",
      );
      UserViewModel.userRegister(user).then((response){
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