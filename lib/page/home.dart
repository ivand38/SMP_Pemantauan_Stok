import 'package:flutter/material.dart';
import 'package:smp_app/page/daftarpiutang.dart';
import 'package:smp_app/page/detailsalesman.dart';
import 'package:smp_app/page/transaksipage.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:smp_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/models/user_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    var logger = Logger();

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo_smp.png', width: 24, height: 24),
                    GestureDetector(
                      onTap: () async {
                        try {
                          // Panggil fungsi logout dari AuthService jika diperlukan
                          await AuthService().logout(
                              authProvider.user.access_token.toString());
                          // Panggil fungsi logout dari AuthProvider
                          authProvider.logout();

                          // Navigasi ke halaman login
                          Navigator.pushReplacementNamed(context, '/login');
                        } catch (e) {
                          logger.d(e);
                          // Handle kesalahan logout
                        }
                      },
                      child: Icon(
                        Icons.logout_sharp,
                        size: 24,
                        color: redTextColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      color: bgColor3, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/asset1.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama:',
                            style: secondaryWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            user.nama.toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Role:',
                            style: secondaryWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            user.role.toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Pilih Menu',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                Divider(
                  color: secondaryTextColor,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                user.role.toString() == 'Kepala Cabang'
                    ? Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/stokpage');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_stok.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Stok',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat stok saat ini',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransaksiPage(user)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_transaksi.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Transaksi',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat transaksi barang',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/omzetpage');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_omzet.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Omzet',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat omzet perusahaan',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'role', user.role.toString());
                                  Navigator.pushNamed(context, '/listsalesman');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_piutang.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Piutang',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat tagihan customer',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailSalesmanPage(
                                                  user.nama.toString())));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_omzet.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Omzet',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat omzet perusahaan',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransaksiPage(user)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_transaksi.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Transaksi',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat transaksi barang',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DaftarPiutangPage(
                                                  user.nama.toString())));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_piutang.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Piutang',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Menu untuk melihat tagihan customer',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
