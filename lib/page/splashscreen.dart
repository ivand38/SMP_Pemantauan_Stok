import 'dart:async';

import 'package:smp_app/page/login.dart';
import 'package:smp_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/stok_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      body: Center(
        child: Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo_smp.png'))),
        ),
      ),
    );
  }
}
