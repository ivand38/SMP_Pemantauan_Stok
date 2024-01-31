import 'package:flutter/material.dart';
import 'package:smp_app/page/omzetcustomer.dart';
import 'package:smp_app/page/omzetproduk.dart';
import 'package:smp_app/page/omzetsalesman.dart';
import 'package:smp_app/theme.dart';
import 'package:material_symbols_icons/symbols.dart';

class OmzetPage extends StatefulWidget {
  const OmzetPage({super.key});

  @override
  State<OmzetPage> createState() => _OmzetPageState();
}

class _OmzetPageState extends State<OmzetPage> {
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buttonNavbar() {
      return Container(
        decoration: BoxDecoration(
          color: bgColor1,
          border: Border(top: BorderSide(color: strokeColor, width: 1)),
        ),
        child: BottomNavigationBar(
            backgroundColor: bgColor1,
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
                  Symbols.person_apron,
                  size: 25,
                ),
                label: '',
              ),
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
          return const OmzetSalesmanPage();
        case 1:
          return const OmzetCustPage();
        case 2:
          return const OmzetProductPage();
        default:
          return const OmzetSalesmanPage();
      }
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buttonNavbar(),
        body: bodyPage(),
      ),
    );
  }
}
