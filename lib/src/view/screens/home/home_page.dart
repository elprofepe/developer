import 'package:el_profe/src/view/screens/home/nav_bottom.dart';
import 'package:el_profe/src/view/screens/home/part/home_fragment.dart';
import 'package:el_profe/src/view/screens/home/part/profile_fragment.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:el_profe/res/colors.dart';

class HomePage extends StatefulWidget {

  HomePage({
    Key key,
    }) : super(key: key); 

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> list;
  StatefulWidget _statefulWidget;
  int _statefulWidgetIndex;
  
  @override
  void initState() {
    super.initState();
    list = [HomeFragment(), ProfileFragment()];
    _statefulWidgetIndex = 0;
    _statefulWidget = list[0];
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    appBar: _statefulWidgetIndex == 0 ? AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        "Bienvenido ${GContext.getUser.name} ${GContext.getUser.lastName}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: accentColor,
        ),
      ),
    ) : null,
    resizeToAvoidBottomInset: false,
    resizeToAvoidBottomPadding: false,
    body: SafeArea(
      child: _statefulWidget
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: _statefulWidgetIndex == 0 ? primaryColor : transparent,
      elevation: _statefulWidgetIndex == 0 ? 6 : 0,
      child: Icon(
        Icons.add,
        color: _statefulWidgetIndex == 0 ? white : transparent,
        size: 30.0,
      ),
      onPressed: _statefulWidgetIndex == 0 ? () => Navigator.pushNamed(context, '/post') : null
    ),
    bottomNavigationBar: BottonNavBar(
      list: [{'name': 'home', 'icon': Icons.home}, {'name': 'perfil', 'icon': Icons.person_outline}],
      width: MediaQuery.of(context).size.width,
      select: (value) => _onSelect(value),
    )
  );

  _onSelect(int index) => setState(() {
    _statefulWidgetIndex = index;
    _statefulWidget = _statefulWidget = list[index];
  });

}