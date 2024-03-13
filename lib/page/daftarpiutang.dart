import 'package:flutter/material.dart';
import 'package:smp_app/models/listhutang_model.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/widget/currencyformat.dart';
import 'package:smp_app/widget/piutang_card.dart';
import 'package:smp_app/providers/detailhutang_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smp_app/models/user_model.dart';
import 'package:smp_app/providers/auth_provider.dart';

class DaftarPiutangPage extends StatefulWidget {
  final String listHutang;
  const DaftarPiutangPage(this.listHutang, {super.key});

  @override
  State<DaftarPiutangPage> createState() => _DaftarPiutangPageState();
}

class _DaftarPiutangPageState extends State<DaftarPiutangPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getSalesman();
    getInit();
  }

  getInit() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<DetailHutangProvider>(context, listen: false)
        .getDetailHutang();
    setState(() {
      _isLoading = false;
    });
  }

  Future<DateTime?> getSalesman() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_salesman', widget.listHutang.toString());
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool _isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    DetailHutangProvider detailHutangProvider =
        Provider.of<DetailHutangProvider>(context);
    List sum_hutang = detailHutangProvider.detailHutangs
        .map((e) => int.parse(e.sisa_utang.toString()))
        .toList();
    num sum_total = sum_hutang.fold(0, (a, b) => a + b);
    return SafeArea(
      child: Scaffold(
          backgroundColor: bgColor1,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: _isSearchClicked
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: primaryTextColor),
                    ),
                  ),
            centerTitle: true,
            title: _isSearchClicked
                ? Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      autofocus: true,
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSearchClicked = !_isSearchClicked;
                                  if (!_isSearchClicked) {
                                    _searchController.clear();
                                  }
                                  searchText = '';
                                });
                              },
                              child: Icon(Icons.arrow_back,
                                  color: secondaryTextColor)),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 20, right: 16, bottom: 12),
                          hintText: 'Cari Nama Customer',
                          hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                          border: InputBorder.none),
                    ),
                  )
                : Text('Detail Piutang Salesman',
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold)),
            titleTextStyle:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _isSearchClicked
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearchClicked = !_isSearchClicked;
                          });
                        },
                        icon: const Icon(Icons.search),
                        color: primaryTextColor,
                      ),
              ),
            ],
          ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: bgColor3,
                  ),
                )
              : detailHutangProvider.detailHutangs.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/data_notfound.png',
                                width: 250,
                                height: 190,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Oops! Tidak ada transaksi',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Maaf, sepertinya tanggal yang anda cari tidak ada data transaksi.',
                                style: secondaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Stack(children: [
                      SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 20, right: 30, left: 30, bottom: 60),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'assets/logo_person.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Nama Salesman',
                                          style: secondaryTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: regular),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.listHutang,
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: semiBold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'List Piutang',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 16, fontWeight: semiBold),
                                  ),
                                  Divider(
                                    color: secondaryTextColor,
                                    thickness: 0.5,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: searchText.isEmpty
                                          ? detailHutangProvider.detailHutangs
                                              .map((detailHutang) =>
                                                  PiutangCard(detailHutang))
                                              .toList()
                                          : detailHutangProvider.detailHutangs
                                                  .where((element) => element
                                                      .nama_customer!
                                                      .toLowerCase()
                                                      .contains(searchText
                                                          .toLowerCase()))
                                                  .isNotEmpty
                                              ? detailHutangProvider
                                                  .detailHutangs
                                                  .where((element) => element
                                                      .nama_customer!
                                                      .toLowerCase()
                                                      .contains(searchText
                                                          .toLowerCase()))
                                                  .map((detailHutang) =>
                                                      PiutangCard(detailHutang))
                                                  .toList()
                                              : [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/notfound.png',
                                                        width: 250,
                                                        height: 190,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        'Oops! Tidak ada hasil',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    semiBold),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Maaf, sepertinya kami tidak dapat menemukan hasil yang sesuai dengan pencarian Anda.',
                                                        style: secondaryTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    regular),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  )
                                                ])
                                ])),
                      ),
                      if (_isSearchClicked == false)
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Piutang',
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold)),
                                  Text(
                                    CurrencyFormat.convertToIdr(sum_total),
                                    style: blueTextStyle.copyWith(
                                        fontSize: 16, fontWeight: semiBold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ])),
    );
  }
}
