import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/detailhutang_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailHutangService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<DetailHutangModel>> getDetailHutang(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String salesman = await prefs.getString('nama_salesman').toString();
    var url = '$baseUrl/hutang/$salesman';
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
      List<DetailHutangModel> detailHutangs = [];

      for (var item in data) {
        detailHutangs.add(DetailHutangModel.fromJson(item));
      }

      return detailHutangs;
    } else {
      List<DetailHutangModel> detailHutangs = [];
      return detailHutangs;
    }
  }
}
