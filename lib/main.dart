import 'package:flutter/material.dart';
import 'package:smp_app/page/changepasspage.dart';
import 'package:smp_app/page/detailsalesman.dart';
import 'package:smp_app/page/forgotpasspage.dart';
import 'package:smp_app/page/home.dart';
import 'package:smp_app/page/listsalesman.dart';
import 'package:smp_app/page/login.dart';
import 'package:smp_app/page/omzetpage.dart';
import 'package:smp_app/page/daftarpiutang.dart';
import 'package:smp_app/page/passcodepage.dart';
import 'package:smp_app/page/splashscreen.dart';
import 'package:smp_app/page/stokpage.dart';
import 'package:smp_app/page/transaksipage.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/detailhutang_provider.dart';
import 'package:smp_app/providers/detailsalescustomer_provider.dart.dart';
import 'package:smp_app/providers/detailsalesproduk_provider.dart';
import 'package:smp_app/providers/listhutang_provider.dart';
import 'package:smp_app/providers/omzetcustomer_provider.dart';
import 'package:smp_app/providers/omzetproduk_provider.dart';
import 'package:smp_app/providers/omzetsalesman_provider.dart';
import 'package:smp_app/providers/stok_provider.dart';
import 'package:smp_app/providers/transaksi_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StokProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransaksiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OmzetCustomerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OmzetProdukProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OmzetSalesmanProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => DetailSalesCustomerProvider()),
        ChangeNotifierProvider(
            create: (context) => DetailSalesProdukProvider()),
        ChangeNotifierProvider(
          create: (context) => ListHutangProvider(),
        ),
        ChangeNotifierProvider(create: (context) => DetailHutangProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/forgotpass': (context) => const ForgotPassPage(),
          '/passcode': (context) => const PassCodePage(),
          '/changepass': (context) => const ChangePassPage(),
          '/homepage': (context) => const HomePage(),
          '/stokpage': (context) => const StokPage(),
          '/omzetpage': (context) => const OmzetPage(),
          '/listsalesman': (context) => const ListSalesmanPage(),
        },
      ),
    );
  }
}
