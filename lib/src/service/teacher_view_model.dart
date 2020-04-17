import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_profe/src/model/teacher_model.dart';
import 'package:el_profe/src/service/base/base_view_model.dart';

class PostulantViewModel {
  static Future<dynamic> setPostulantData(Teacher _user) {
    String id = Firestore.instance.collection('postulants').document().documentID;
    return Firestore.instance.collection("postulants").document(id).setData(_user.toJson()).then((onValue) async {
      return [0, 'Has postulado con exito al puesto por favor espere su respuesta via correo o por llamada'];
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }
  
}