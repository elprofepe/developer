import 'package:el_profe/src/model/user_model.dart';
import 'package:el_profe/src/service/user_view_model.dart';
import 'package:el_profe/src/view/screens/home/home_page.dart';
import 'package:el_profe/src/view/screens/main/main_page.dart';
import 'package:el_profe/src/view/screens/main/postulant/postulant_page.dart';
import 'package:el_profe/src/view/screens/main/signIn/sign_in_page.dart';
import 'package:el_profe/src/view/screens/main/signUp/sign_up_page.dart';
import 'package:el_profe/src/view/screens/post/post_page.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  Future<MapEntry<String, dynamic>> routePage() async {
    bool _loged = await UserViewModel.isUserLoged();
    if (_loged) {
      await UserViewModel.getUserLocal().then((_user) {
        GContext.setsetUser(_user);
      });
    }
    return _loged ? MapEntry('/home', null) : MapEntry('/main', null);
  }

  @override
  Widget build(BuildContext context) {
    GContext.init(context);
    return MaterialApp(
      title: 'El profe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/main': (_) => MainPage(),
        '/home': (_) => HomePage(),
        '/sign/in': (_) => SignInPage(),
        '/sign/up': (_) => SignUpPage(),
        '/postulant': (_) => PostulantPage(),
        '/post': (_) => PostPage(),
      },
      home: FutureBuilder<MapEntry<String, dynamic>>(
        future: routePage(),
        builder: (context, snapshot) {
          String route = snapshot?.data?.key ?? '/loader';
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          GContext.setSize(width, height);

          switch (route) {
            case '/main':
              return MainPage();
              break;
            case '/home':
              return HomePage();
              break;
            case '/loader':
            default:
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Image.asset('assets/images/logo.png'),
              );
              break;
          }
        }
      )
    );
  }
}
