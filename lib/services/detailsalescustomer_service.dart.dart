import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/detailsalescustomer_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSalesCustomerService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<DetailSalesCustomerModel>> getDetailSalesCustomer(
      String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String parameter = await prefs.getString('parameter').toString();
    var url = '$baseUrl/omzet/salesman/cari/$parameter';
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
      List data = json.decode(response.body)['data']['customer'];
      List<DetailSalesCustomerModel> detailSalesCustomers = [];

      for (var item in data) {
        detailSalesCustomers.add(DetailSalesCustomerModel.fromJson(item));
      }

      return detailSalesCustomers;
    } else {
      List<DetailSalesCustomerModel> detailSalesCustomers = [];
      return detailSalesCustomers;
    }
  }
}
