import 'package:smp_app/services/omzetproduk_service.dart';
import 'package:smp_app/models/omzetproduk_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetProdukProvider with ChangeNotifier {
  List<OmzetProdukModel> _omzetProduks = [];

  List<OmzetProdukModel> get omzetProduks => _omzetProduks;
  var logger = Logger();

  set omzetProduks(List<OmzetProdukModel> omzetProduks) {
    _omzetProduks = omzetProduks;
    notifyListeners();
  }

  Future<void> getOmzetProduk() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<OmzetProdukModel> omzetProduks = await OmzetProdukService()
          .getOmzetProduk(await prefs.getString('token').toString());
      _omzetProduks = omzetProduks;
    } catch (e) {
      logger.d(e);
    }
  }
}
