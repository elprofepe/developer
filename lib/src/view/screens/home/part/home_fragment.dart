import 'package:el_profe/res/colors.dart';
import 'package:el_profe/src/model/post_model.dart';
import 'package:el_profe/src/service/post_view_model.dart';
import 'package:el_profe/src/view/screens/home/part/item_home.dart';
import 'package:el_profe/src/view/widgets/column_loading_card.dart';
import 'package:el_profe/src/view/widgets/error_message.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';

class HomeFragment extends StatefulWidget {

  HomeFragment({
    Key key,
    }) : super(key: key); 

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: PostViewModel.haveOneTherapiesActive(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting: return ColumnLoadingCard();        
        break;
        case ConnectionState.done: {
          if (snapshot.hasData) {
            switch (snapshot.data[0]) {
              case 0: {
                List<Post> posts = snapshot.data[1];
                // return ListView(
                //   padding: EdgeInsets.symmetric(vertical: 20.0),
                //   children: <Widget>[
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.stretch,
                //       children: posts.map((request){
                //         return ItemHomeFragment(
                //           isFirst: request,
                //           post: request,
                //         );
                //       }).toList(),
                //     )
                //   ],
                // );

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ItemHomeFragment(
                      isFirst: index == 0,
                      post: posts[index],
                    );
                  }
                );


              }
              break;
              default: {
                return ErrorMessage(
                    errorMessage: snapshot.data[1],
                    colorTB: grayTextForm,
                    action: () => setState(() {}),
                );
              }
            }
          } else {
            return ErrorMessage(
                errorMessage: "No se pudo obtener información",
                colorTB: grayTextForm,
                action: () => setState(() {}),
            );
          }
        }
        break;
        case ConnectionState.none: return ColumnLoadingCard();
        break;
        case ConnectionState.active: return ColumnLoadingCard();
        break;
        default: return ColumnLoadingCard();
      }
    }
  );
}