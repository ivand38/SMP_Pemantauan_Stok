import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/stok_model.dart';
import 'package:logger/logger.dart';

class StokService {
  var logger = Logger();
  String baseUrl = 'https://sismp.online/api';

  Future<List<StokModel>> getStok(String token) async {
    var url = '$baseUrl/stok';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
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
