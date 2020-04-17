import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_profe/src/model/user_model.dart';
import 'package:el_profe/src/service/base/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel {

  static Future<bool> isUserLoged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoged') ?? false;
  }

  static Future<bool> setUserLoged(b, user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoged', b);
    prefs.setString('user', json.encode(user));
    return true;
  }

  static Future<User> setUserLocal(user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user));
    return user;
  }

  static Future<User> getUserLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var userMap = json.decode(prefs.getString("user"));
    var user = User.fromMap(userMap);
    return user;
  }

  static Future<dynamic> userLogin(User _user) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: _user.email, password: _user.password).then((result) async {
      if (result.user.isEmailVerified) {
        return getUserData(result.user);
      } else {
        return [12, 'Verifica tu correo'];
      }
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }

  static Future<dynamic> userRegister(User _user) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: _user.email, password: _user.password).then((result) async {
      await result.user.sendEmailVerification();
      _user.uid = result.user.uid;
      return setUserData(result.user, _user);
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }

  static Future<dynamic> getUserData(FirebaseUser firebaseUser) {
    return Firestore.instance.collection("users").document(firebaseUser.uid).get().then((onValue) async {
      var userModel = User.fromMap(onValue.data);
      setUserLoged(true, userModel);
      return [0, userModel];
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }

  static Future<dynamic> setUserData(FirebaseUser firebaseUser, User _user) {
    return Firestore.instance.collection("users").document(firebaseUser.uid).setData(_user.toJson()).then((onValue) async {
      return [0, 'Verifique su correo'];
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }
  
}