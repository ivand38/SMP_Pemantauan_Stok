import 'package:smp_app/services/stok_service.dart';
import 'package:smp_app/models/stok_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StokProvider with ChangeNotifier {
  List<StokModel> _stoks = [];

  List<StokModel> get stoks => _stoks;
  var logger = Logger();

  set stoks(List<StokModel> stoks) {
    _stoks = stoks;
    notifyListeners();
  }

  Future<void> getStok() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<StokModel> stoks = await StokService()
          .getStok(await prefs.getString('token').toString());
      _stoks = stoks;
    } catch (e) {
      logger.d(e);
    }
  }
}
