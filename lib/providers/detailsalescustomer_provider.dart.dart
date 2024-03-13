import 'package:smp_app/services/detailsalescustomer_service.dart.dart';
import 'package:smp_app/models/detailsalescustomer_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSalesCustomerProvider with ChangeNotifier {
  List<DetailSalesCustomerModel> _detailSalesCustomers = [];

  List<DetailSalesCustomerModel> get detailSalesCustomers =>
      _detailSalesCustomers;
  var logger = Logger();

  set detailSalesCustomers(
      List<DetailSalesCustomerModel> detailSalesCustomers) {
    _detailSalesCustomers = detailSalesCustomers;
    notifyListeners();
  }

  Future<void> getDetailSalesCustomer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<DetailSalesCustomerModel> detailSalesCustomers =
          await DetailSalesCustomerService().getDetailSalesCustomer(
              await prefs.getString('token').toString());
      _detailSalesCustomers = detailSalesCustomers;
    } catch (e) {
      logger.d(e);
    }
  }
}
