import 'package:flutter/material.dart';
import 'package:smp_app/models/transaksi_model.dart';
import 'package:smp_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smp_app/widget/transaksi_card.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/transaksi_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smp_app/models/user_model.dart';

class TransaksiPage extends StatefulWidget {
  final UserModel userModel;
  const TransaksiPage(this.userModel, {super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 6)),
    end: DateTime.now(),
  );

  // DateTime _dateTime = DateTime.now();
  DateFormat myFormat = DateFormat('dd MMM yyyy');
  DateFormat apiFormat = DateFormat('yyyy-MM-dd');

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    setState(() {
      _isLoading = true;
    });
    getDate();
    await Provider.of<TransaksiProvider>(context, listen: false).getTransaksi();
    setState(() {
      _isLoading = false;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  Future<DateTime?> getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('daterange_transaksi',
        '${apiFormat.format(dateRange.start)}/${apiFormat.format(dateRange.end)}');
  }

  bool _isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    TransaksiProvider transaksiProvider =
        Provider.of<TransaksiProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
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
              : Text('Data Transaksi',
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
        backgroundColor: bgColor1,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: bgColor3,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 30, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: GestureDetector(
                          onTap: pickDateRange,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: bgColor3, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(children: [
                              Icon(
                                Symbols.calendar_month,
                                size: 20,
                                color: bgColor3,
                              ),
                              Icon(
                                Symbols.arrow_drop_down,
                                size: 20,
                                color: bgColor3,
                              ),
                              start == end
                                  ? Text(
                                      '${myFormat.format(start)}',
                                      style: blueTextStyle.copyWith(
                                          fontSize: 12, fontWeight: medium),
                                    )
                                  : Text(
                                      '${myFormat.format(start)} - ${myFormat.format(end)}',
                                      style: blueTextStyle.copyWith(
                                          fontSize: 12, fontWeight: medium),
                                    )
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.userModel.role.toString() !=
                                  'Salesman'
                              // Bukan Role Salesman
                              ? searchText.isEmpty
                                  ? transaksiProvider.transaksis.isNotEmpty
                                      ? transaksiProvider.transaksis
                                          .map((transaksi) =>
                                              TransaksiCard(transaksi))
                                          .toList()
                                      : [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: semiBold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Maaf, sepertinya tanggal yang anda cari tidak ada data transaksi.',
                                                style:
                                                    secondaryTextStyle.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: regular),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          )
                                        ]
                                  : transaksiProvider.transaksis
                                          .where((element) => element.nama_customer!
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()))
                                          .isNotEmpty
                                      ? transaksiProvider.transaksis
                                          .where((element) => element.nama_customer!
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()))
                                          .map((transaksi) =>
                                              TransaksiCard(transaksi))
                                          .toList()
                                      : [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: semiBold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Maaf, sepertinya kami tidak dapat menemukan hasil yang sesuai dengan pencarian Anda.',
                                                style:
                                                    secondaryTextStyle.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: regular),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          )
                                        ]
                              //Jika role salesman
                              : searchText.isEmpty
                                  ? transaksiProvider.transaksis
                                          .where((element) =>
                                              element.nama_salesman ==
                                              widget.userModel.nama.toString())
                                          .isNotEmpty
                                      ? transaksiProvider.transaksis
                                          .where((element) => element.nama_salesman == widget.userModel.nama.toString())
                                          .map((transaksi) => TransaksiCard(transaksi))
                                          .toList()
                                      : [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: semiBold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Maaf, sepertinya tanggal yang anda cari tidak ada data transaksi.',
                                                style:
                                                    secondaryTextStyle.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: regular),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          )
                                        ]
                                  : transaksiProvider.transaksis.where((element) => element.nama_salesman == widget.userModel.nama.toString()).where((element) => element.nama_customer!.toLowerCase().contains(searchText.toLowerCase())).isNotEmpty
                                      ? transaksiProvider.transaksis.where((element) => element.nama_salesman == widget.userModel.nama.toString()).where((element) => element.nama_customer!.toLowerCase().contains(searchText.toLowerCase())).map((transaksi) => TransaksiCard(transaksi)).toList()
                                      : [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: semiBold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Maaf, sepertinya kami tidak dapat menemukan hasil yang sesuai dengan pencarian Anda.',
                                                style:
                                                    secondaryTextStyle.copyWith(
                                                        fontSize: 14,
                                                        fontWeight: regular),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          )
                                        ])
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        barrierColor: bgColor3,
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
      getDate();
      getInit();
    });
  }
}
