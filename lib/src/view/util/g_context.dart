import 'package:flutter/material.dart';
import 'package:el_profe/src/model/user_model.dart';

class GContext {
  static BuildContext _context;
  static double _height;
  static double _width;
  static User _user;

  static init(BuildContext context) {
    _context = context;
  }

  static Future setSize(double w, double h) async {
    _width = w;
    _height = h;
  }
  static Future setsetUser(User u) async => _user = u;
  
  static User  get getUser => _user;

  static double get getWidth => _width;

  static double get getHeight => _height;

  static BuildContext get getContext => _context;
}