import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/omzetproduk_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetProdukService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<OmzetProdukModel>> getOmzetProduk(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String daterange =
        await prefs.getString('daterange_omzetProduk').toString();
    var url = '$baseUrl/omzet/produk/$daterange';
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
      List<OmzetProdukModel> omzetProduks = [];

      for (var item in data) {
        omzetProduks.add(OmzetProdukModel.fromJson(item));
      }

      return omzetProduks;
    } else {
      throw Exception('Gagal Mengambil Data Omzet Produk');
    }
  }
}
