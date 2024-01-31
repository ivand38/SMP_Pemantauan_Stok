import 'package:flutter/material.dart';
import 'package:smp_app/page/detailsalesman.dart';
import 'package:smp_app/page/home.dart';
import 'package:smp_app/page/login.dart';
import 'package:smp_app/page/omzetpage.dart';
import 'package:smp_app/page/piutangpage.dart';
import 'package:smp_app/page/splashscreen.dart';
import 'package:smp_app/page/stokpage.dart';
import 'package:smp_app/page/transaksipage.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/stok_provider.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/homepage': (context) => const HomePage(),
          '/stokpage': (context) => const StokPage(),
          '/transaksipage': (context) => const TransaksiPage(),
          '/omzetpage': (context) => const OmzetPage(),
          '/detailsalesman': (context) => const DetailSalesmanPage(),
          '/piutangpage': (context) => const DaftarPiutangPage()
        },
      ),
    );
  }
}
