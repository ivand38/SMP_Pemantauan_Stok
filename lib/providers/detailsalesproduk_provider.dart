import 'package:smp_app/services/detailsalesproduk_service.dart';
import 'package:smp_app/models/detailsalesproduk_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSalesProdukProvider with ChangeNotifier {
  List<DetailSalesProdukModel> _detailSalesProduks = [];

  List<DetailSalesProdukModel> get detailSalesProduks => _detailSalesProduks;
  var logger = Logger();

  set detailSalesProduks(List<DetailSalesProdukModel> detailSalesProduks) {
    _detailSalesProduks = detailSalesProduks;
    notifyListeners();
  }

  Future<void> getDetailSalesProduk() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<DetailSalesProdukModel> detailSalesProduks =
          await DetailSalesProdukService()
              .getDetailSalesProduk(await prefs.getString('token').toString());
      _detailSalesProduks = detailSalesProduks;
    } catch (e) {
      logger.d(e);
    }
  }
}
