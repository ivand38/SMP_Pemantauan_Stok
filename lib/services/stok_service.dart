import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smp_app/models/stok_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StokService {
  var logger = Logger();
  String baseUrl = 'https://9686-36-65-180-137.ngrok-free.app/api';

  Future<List<StokModel>> getStok(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String datetime = await prefs.getString('apidate').toString();
    var url = '$baseUrl/stok/$datetime';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    logger.d(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<StokModel> stoks = [];

      for (var item in data) {
        stoks.add(StokModel.fromJson(item));
      }

      return stoks;
    } else {
      throw Exception('Gagal Mengambil Data Stok');
    }
  }
}
