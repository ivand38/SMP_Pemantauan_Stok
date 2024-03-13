import 'package:flutter/material.dart';
import 'package:smp_app/models/omzetsalesman_model.dart';
import 'package:smp_app/page/detailsalescustomer.dart';
import 'package:smp_app/page/detailsalesproduk.dart';
import 'package:smp_app/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';

class DetailSalesmanPage extends StatefulWidget {
  final String omzetSalesman;
  const DetailSalesmanPage(this.omzetSalesman, {super.key});

  @override
  State<DetailSalesmanPage> createState() => _DetailSalesmanPageState();
}

class _DetailSalesmanPageState extends State<DetailSalesmanPage> {
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buttonNavbar() {
      return Container(
        decoration: BoxDecoration(
          color: bgColor1,
        ),
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            unselectedItemColor: greyColor,
            selectedItemColor: bgColor3,
            currentIndex: _currentindex,
            onTap: (value) {
              setState(() {
                _currentindex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Symbols.storefront,
                    size: 25,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Symbols.medication,
                    size: 25,
                  ),
                  label: ''),
            ]),
      );
    }

    Widget bodyPage() {
      switch (_currentindex) {
        case 0:
          return DetailSalesCustomerPage(widget.omzetSalesman);
        case 1:
          return DetailSalesProdukPage(widget.omzetSalesman);
        default:
          return DetailSalesCustomerPage(widget.omzetSalesman);
      }
    }

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: buttonNavbar(),
        body: bodyPage(),
      ),
    );
  }
}
