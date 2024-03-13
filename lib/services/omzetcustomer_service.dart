import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/omzetcustomer_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetCustomerService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<OmzetCustomerModel>> getOmzetCustomer(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String daterange = await prefs.getString('daterange_omzetCust').toString();
    var url = '$baseUrl/omzet/customer/$daterange';
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
      List<OmzetCustomerModel> omzetCustomers = [];

      for (var item in data) {
        omzetCustomers.add(OmzetCustomerModel.fromJson(item));
      }

      return omzetCustomers;
    } else {
      throw Exception('Gagal Mengambil Data Omzet Customer');
    }
  }
}
