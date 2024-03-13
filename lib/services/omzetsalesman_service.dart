import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/omzetsalesman_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetSalesmanService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<OmzetSalesmanModel>> getOmzetSalesman(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String daterange = await prefs.getString('daterange_omzetSales').toString();
    var url = '$baseUrl/omzet/salesman/$daterange';
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
      List<OmzetSalesmanModel> omzetSalesmans = [];

      for (var item in data) {
        omzetSalesmans.add(OmzetSalesmanModel.fromJson(item));
      }

      return omzetSalesmans;
    } else {
      throw Exception('Gagal Mengambil Data Omzet Salesman');
    }
  }
}
