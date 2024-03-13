import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/widget/detailsalesproduk_card.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/detailsalesproduk_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smp_app/widget/currencyformat.dart';
import 'package:smp_app/models/omzetsalesman_model.dart';
import 'package:collection/collection.dart';

class DetailSalesProdukPage extends StatefulWidget {
  final String omzetSalesman;
  const DetailSalesProdukPage(this.omzetSalesman, {super.key});

  @override
  State<DetailSalesProdukPage> createState() => _DetailSalesProdukPageState();
}

class _DetailSalesProdukPageState extends State<DetailSalesProdukPage> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 6)),
    end: DateTime.now(),
  );

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getParameter();
    getInit();
  }

  getInit() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<DetailSalesProdukProvider>(context, listen: false)
        .getDetailSalesProduk();
    setState(() {
      _isLoading = false;
    });
  }

  Future<DateTime?> getParameter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('parameter',
        '${apiFormat.format(dateRange.start)}/${apiFormat.format(dateRange.end)}/${widget.omzetSalesman}');
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  // DateTime _dateTime = DateTime.now();
  DateFormat myFormat = DateFormat('dd MMM yyyy');
  DateFormat apiFormat = DateFormat('yyyy-MM-dd');

  bool _isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    DetailSalesProdukProvider detailSalesProdukProvider =
        Provider.of<DetailSalesProdukProvider>(context);
    final start = dateRange.start;
    final end = dateRange.end;
    List sum_omzet = detailSalesProdukProvider.detailSalesProduks
        .map((e) => int.parse(e.total_omzet.toString()))
        .toList();
    num sum_total = sum_omzet.fold(0, (a, b) => a + b);
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
                            hintStyle:
                                secondaryTextStyle.copyWith(fontSize: 14),
                            border: InputBorder.none),
                      ),
                    )
                  : Text('Detail Omzet Salesman',
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
              ]),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: bgColor3,
                  ),
                )
              : detailSalesProdukProvider.detailSalesProduks.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 30, left: 30, right: 30),
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
                                        color: bgColor3,
                                        style: BorderStyle.solid),
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
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                      'Oops! Tidak ada data omzet',
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Maaf, sepertinya tanggal yang anda cari tidak ada data omzet.',
                                      style: secondaryTextStyle.copyWith(
                                          fontSize: 14, fontWeight: regular),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Stack(children: [
                      SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 20, right: 30, left: 30, bottom: 60),
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
                                                color: bgColor3,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(20)),
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
                                                      fontSize: 12,
                                                      fontWeight: medium),
                                                )
                                              : Text(
                                                  '${myFormat.format(start)} - ${myFormat.format(end)}',
                                                  style: blueTextStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: medium),
                                                )
                                        ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                          widget.omzetSalesman.toString(),
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
                                    'List Produk Yang Diambil',
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
                                          ? detailSalesProdukProvider
                                              .detailSalesProduks
                                              .map((detailSalesProduk) =>
                                                  DetailSalesProdukCard(
                                                      detailSalesProduk))
                                              .toList()
                                          : detailSalesProdukProvider
                                                  .detailSalesProduks
                                                  .where((element) => element
                                                      .nama_produk!
                                                      .toLowerCase()
                                                      .contains(searchText
                                                          .toLowerCase()))
                                                  .isNotEmpty
                                              ? detailSalesProdukProvider
                                                  .detailSalesProduks
                                                  .where((element) => element
                                                      .nama_produk!
                                                      .toLowerCase()
                                                      .contains(searchText
                                                          .toLowerCase()))
                                                  .map((detailSalesProduk) => DetailSalesProdukCard(detailSalesProduk))
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
                                                ]),
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
                                  Text('Total Omzet',
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
      getParameter();
      getInit();
    });
  }
}
