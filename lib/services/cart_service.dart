import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smp_app/models/cartdata_model.dart';
import 'package:smp_app/models/datamaster_model.dart';

class CartService {
  var logger = Logger();
  String baseUrl = 'https://sismp.online/api';

  Future addCart(
      {String? produk_id,
      String? no_batch,
      String? tanggal_kedaluwarsa,
      String? jumlah_keluar,
      String? diskon,
      String? harga_jual}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token').toString();
    var url = '$baseUrl/cart/add';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'produk_id': produk_id,
      'no_batch': no_batch,
      'tanggal_kedaluwarsa': tanggal_kedaluwarsa,
      'jumlah_keluar': jumlah_keluar,
      'diskon': diskon,
      'harga_jual': harga_jual
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.d(response.statusCode);
    } else {
      throw Exception('Gagal Add Barang ke Keranjang ${response.statusCode}');
    }
  }

  Future<List<CartDataModel>> getCart(String token) async {
    var url = '$baseUrl/cart';
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
      List data = json.decode(response.body)['cartData'];
      List<CartDataModel> carts = [];
      int total = json.decode(response.body)['total'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('total', total.toString());

      for (var item in data) {
        carts.add(CartDataModel.fromJson(item));
      }

      return carts;
    } else {
      throw Exception('Gagal Mengambil Data Cart');
    }
  }

  Future<List<DataMasterModel>> getMaster(String token) async {
    var url = '$baseUrl/barangmasuk';
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
      List data = json.decode(response.body)['data']['data'];
      List<DataMasterModel> datas = [];

      for (var item in data) {
        datas.add(DataMasterModel.fromJson(item));
      }

      return datas;
    } else {
      throw Exception('Gagal Mengambil Data Master');
    }
  }

  Future addTransaksi(
      {String? kode_transaksi,
      String? tanggal_transaksi,
      int? subtotal,
      String? diskon,
      int? total,
      String? customer_id,
      String? metode,
      String? bayar}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token').toString();
    var url = '$baseUrl/addTransaksi';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'kode_transaksi': kode_transaksi,
      'tanggal_transaksi': tanggal_transaksi,
      'subtotal': subtotal,
      'diskon': diskon,
      'total': total,
      'customer_id': customer_id,
      'metode': metode,
      'bayar': bayar
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    logger.d(response.body);

    if (response.statusCode == 200) {
      logger.d(response.statusCode);
    } else {
      throw Exception('Gagal Add Barang ke Keranjang ${response.statusCode}');
    }
  }

  Future deleteCart(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token').toString();
    var url = '$baseUrl/cart/delete/$id';
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
}
