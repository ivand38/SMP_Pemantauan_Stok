import 'package:smp_app/services/transaksi_service.dart';
import 'package:smp_app/models/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiProvider with ChangeNotifier {
  List<TransaksiModel> _transaksis = [];

  List<TransaksiModel> get transaksis => _transaksis;
  var logger = Logger();

  set transaksis(List<TransaksiModel> transaksis) {
    _transaksis = transaksis;
    notifyListeners();
  }

  Future<void> getTransaksi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<TransaksiModel> transaksis = await TransaksiService()
          .getTransaksi(await prefs.getString('token').toString());
      _transaksis = transaksis;
    } catch (e) {
      logger.d(e);
    }
  }
}
