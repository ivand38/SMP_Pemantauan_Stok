import 'package:smp_app/models/datamaster_model.dart';
import 'package:smp_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smp_app/models/cartdata_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  var logger = Logger();
  List<CartDataModel> _carts = [];

  List<CartDataModel> get carts => _carts;

  set carts(List<CartDataModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  List<DataMasterModel> _datas = [];

  List<DataMasterModel> get datas => _datas;

  set datas(List<DataMasterModel> datas) {
    _datas = datas;
    notifyListeners();
  }

  Future<bool> addCart(
      {String? produk_id,
      String? no_batch,
      String? tanggal_kedaluwarsa,
      String? jumlah_keluar,
      String? diskon,
      String? harga_jual}) async {
    try {
      await CartService().addCart(
          produk_id: produk_id,
          no_batch: no_batch,
          tanggal_kedaluwarsa: tanggal_kedaluwarsa,
          jumlah_keluar: jumlah_keluar,
          diskon: diskon,
          harga_jual: harga_jual);
      logger.d('Add Cart Berhasil');
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  Future<void> getCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<CartDataModel> carts = await CartService()
          .getCart(await prefs.getString('token').toString());
      _carts = carts;
    } catch (e) {
      logger.d(e);
    }
  }

  Future<void> getMaster() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<DataMasterModel> datas = await CartService()
          .getMaster(await prefs.getString('token').toString());
      _datas = datas;
    } catch (e) {
      logger.d(e);
    }
  }

  Future<bool> addTransaksi(
      {String? kode_transaksi,
      String? tanggal_transaksi,
      int? subtotal,
      String? diskon,
      int? total,
      String? customer_id,
      String? metode,
      String? bayar}) async {
    try {
      await CartService().addTransaksi(
          kode_transaksi: kode_transaksi,
          tanggal_transaksi: tanggal_transaksi,
          subtotal: subtotal,
          diskon: diskon,
          total: total,
          customer_id: customer_id,
          metode: metode,
          bayar: bayar);
      logger.d('Add Transaksi Berhasil');
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  Future<bool> deleteCart(String? id) async {
    try {
      await CartService().deleteCart(id.toString());
      logger.d('Delete Berhasil');
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }
}
