import 'package:el_profe/res/colors.dart';
import 'package:el_profe/src/model/user_model.dart';
import 'package:el_profe/src/service/user_view_model.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';

class ProfileFragment extends StatefulWidget {

  ProfileFragment({
    Key key,
    }) : super(key: key); 

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Widget _customDivider() => Container(
    width: double.infinity,
    height: 1.0,
    margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
    color: grayTextForm,
  );

  Widget _textF(IconData icon, title, text) => ListTile(
    leading: Icon(
      icon
    ),
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: grayTextForm,
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
    ),
    subtitle: Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: grayTextForm,
        fontSize: 15,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Container(
        height: 180.0,
        width: 180.0,
        margin: EdgeInsets.symmetric(vertical: 24.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          GContext.getUser.name.toUpperCase().substring(0, 1),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      _customDivider(),
      _textF(Icons.person, 'Nombre completo', '${GContext.getUser.name} ${GContext.getUser.lastName}'),
      _textF(Icons.mail, 'Correo', GContext.getUser.email),
      _textF(Icons.date_range, 'Fecha de nacimiento', GContext.getUser.birthdate),
      _customDivider(),
      Expanded(
        child: Container(),
      ),
      Center(
        child: FlatButton(
          onPressed: () => _logout(),
          child: Text(
            "CERRAR SESIÓN",
            style: TextStyle(
              color: grayTextForm,
              fontSize: 14.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    ],
  );
  
  _logout() {
    UserViewModel.setUserLoged(false, User()).then((onValue){
      Navigator.pushNamedAndRemoveUntil(context, '/main', ModalRoute.withName('/main'));
    });
  }
}