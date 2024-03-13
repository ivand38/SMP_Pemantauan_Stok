import 'package:smp_app/services/omzetcustomer_service.dart';
import 'package:smp_app/models/omzetcustomer_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmzetCustomerProvider with ChangeNotifier {
  List<OmzetCustomerModel> _omzetCustomers = [];

  List<OmzetCustomerModel> get omzetCustomers => _omzetCustomers;
  var logger = Logger();

  set omzetCustomers(List<OmzetCustomerModel> omzetCustomers) {
    _omzetCustomers = omzetCustomers;
    notifyListeners();
  }

  Future<void> getOmzetCustomer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<OmzetCustomerModel> omzetCustomers = await OmzetCustomerService()
          .getOmzetCustomer(await prefs.getString('token').toString());
      _omzetCustomers = omzetCustomers;
    } catch (e) {
      logger.d(e);
    }
  }
}
