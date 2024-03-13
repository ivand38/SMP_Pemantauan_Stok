import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smp_app/models/user_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.access_token = 'Bearer ' + data['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.access_token.toString());
      logger.d(user.access_token);
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<void> logout(String token) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.d('Logout Berhasil');
    } else {
      throw Exception('Gagal Logout');
    }
  }

  Future<void> GenerateCode(String? email) async {
    var url = '$baseUrl/password/email';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.d('Kode Telah Terkirim Ke Email');
    } else {
      throw Exception('Gagal Generate Kode');
    }
  }

  Future<void> CheckCode(String? code) async {
    var url = '$baseUrl/password/code/check';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'code': code,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);
    logger.d('code: $code');

    if (response.statusCode == 200) {
      logger.d('Kode Berhasil Dicek');
    } else {
      throw Exception('Kode Salah');
    }
  }

  Future<void> ChangePassword(String? password) async {
    var url = '$baseUrl/password/reset';
    var headers = {'Content-Type': 'application/json'};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString('changecode').toString();
    var body = jsonEncode({
      'code': code,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.d('Password Berhasil Diganti');
    } else {
      throw Exception('Password Gagal Diganti');
    }
  }
}
