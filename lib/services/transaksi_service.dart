import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/transaksi_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<TransaksiModel>> getTransaksi(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String daterange = await prefs.getString('daterange_transaksi').toString();
    var url = '$baseUrl/transaksi/$daterange';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    logger.d(response.body);
    logger.d(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<TransaksiModel> transaksis = [];

      for (var item in data) {
        transaksis.add(TransaksiModel.fromJson(item));
      }

      return transaksis;
    } else {
      throw Exception('Gagal Mengambil Data Transaksi');
    }
  }
}
