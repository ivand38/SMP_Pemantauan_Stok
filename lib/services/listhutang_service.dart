import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_app/models/listhutang_model.dart';
import 'package:logger/logger.dart';

class ListHutangService {
  var logger = Logger();
  String baseUrl = 'https://79ff-36-65-189-223.ngrok-free.app/api';

  Future<List<ListHutangModel>> getListHutang(String token) async {
    var url = '$baseUrl/hutang';
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
      List<ListHutangModel> listHutangs = [];

      for (var item in data) {
        listHutangs.add(ListHutangModel.fromJson(item));
      }

      return listHutangs;
    } else {
      List<ListHutangModel> listHutangs = [];
      return listHutangs;
    }
  }
}
