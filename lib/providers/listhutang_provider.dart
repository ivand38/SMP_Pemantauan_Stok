import 'package:smp_app/services/listhutang_service.dart';
import 'package:smp_app/models/listhutang_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListHutangProvider with ChangeNotifier {
  List<ListHutangModel> _listHutangs = [];

  List<ListHutangModel> get listHutangs => _listHutangs;
  var logger = Logger();

  set listHutangs(List<ListHutangModel> listHutangs) {
    _listHutangs = listHutangs;
    notifyListeners();
  }

  Future<void> getListHutang() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<ListHutangModel> listHutangs = await ListHutangService()
          .getListHutang(await prefs.getString('token').toString());
      _listHutangs = listHutangs;
    } catch (e) {
      logger.d(e);
    }
  }
}
