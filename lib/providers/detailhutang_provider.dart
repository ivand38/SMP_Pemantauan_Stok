import 'package:smp_app/services/detailhutang_service.dart';
import 'package:smp_app/models/detailhutang_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailHutangProvider with ChangeNotifier {
  List<DetailHutangModel> _detailHutangs = [];

  List<DetailHutangModel> get detailHutangs => _detailHutangs;
  var logger = Logger();

  set detailHutangs(List<DetailHutangModel> detailHutangs) {
    _detailHutangs = detailHutangs;
    notifyListeners();
  }

  Future<void> getDetailHutang() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<DetailHutangModel> detailHutangs = await DetailHutangService()
          .getDetailHutang(await prefs.getString('token').toString());
      _detailHutangs = detailHutangs;
    } catch (e) {
      logger.d(e);
    }
  }
}
