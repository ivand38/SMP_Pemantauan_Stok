import "package:smp_app/models/user_model.dart";
import 'package:smp_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;
  var logger = Logger();

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  Future<void> logout() async {
    _user.access_token = null;
    notifyListeners();
  }
}
