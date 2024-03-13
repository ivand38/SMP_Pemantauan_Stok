import 'package:smp_app/services/omzetsalesman_service.dart';
import 'package:smp_app/models/omzetsalesman_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetSalesmanProvider with ChangeNotifier {
  List<OmzetSalesmanModel> _omzetSalesmans = [];

  List<OmzetSalesmanModel> get omzetSalesmans => _omzetSalesmans;
  var logger = Logger();

  set omzetSalesmans(List<OmzetSalesmanModel> omzetSalesmans) {
    _omzetSalesmans = omzetSalesmans;
    notifyListeners();
  }

  Future<void> getOmzetSalesman() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<OmzetSalesmanModel> omzetSalesmans = await OmzetSalesmanService()
          .getOmzetSalesman(await prefs.getString('token').toString());
      _omzetSalesmans = omzetSalesmans;
    } catch (e) {
      logger.d(e);
    }
  }
}
