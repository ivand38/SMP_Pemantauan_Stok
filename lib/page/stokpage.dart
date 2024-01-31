import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import 'package:smp_app/models/stok_model.dart';
import 'package:smp_app/providers/stok_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StokPage extends StatefulWidget {
  const StokPage({super.key});

  @override
  State<StokPage> createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
  // DateTimeRange dateRange = DateTimeRange(
  //   start: DateTime.now(),
  //   end: DateTime.now(),
  // );

  DateTime _dateTime = DateTime.now();
  DateFormat myFormat = DateFormat('dd MMMM yyyy');

  int _currentPage = 1;
  int _pageSize = 10;
  bool _isLoading = false;

  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    getDate();
    getInit();
  }

  getInit() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<StokProvider>(context, listen: false).getStok();
    setState(() {
      _isLoading = false;
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        getDate();
        getInit();
      });
    });
  }

  Future<DateTime?> getDate() async {
    DateFormat apiFormat = DateFormat('yyyy-MM-dd');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apidate', apiFormat.format(_dateTime).toString());
    return _dateTime;
  }

  @override
  Widget build(BuildContext context) {
    StokProvider stokProvider = Provider.of<StokProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Data Persediaan Barang'),
          titleTextStyle:
              primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: GestureDetector(
                          onTap: () {
                            _showDatePicker();
                          },
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
                              Text(
                                myFormat.format(_dateTime).toString(),
                                style: purpleTextStyle.copyWith(
                                    fontSize: 12, fontWeight: regular),
                              )
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Theme(
                        data: tableTheme,
                        child: PaginatedDataTable(
                          headingRowColor:
                              MaterialStatePropertyAll(Colors.grey.shade300),
                          rowsPerPage: 10,
                          columnSpacing: 25,
                          columns: [
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('No',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Nama Produk',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Satuan',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Stok Awal',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Stok Masuk',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Stok Keluar',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Stok Akhir',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    )),
                              ),
                            )),
                          ],
                          source: StockData(data: stokProvider.stoks),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class StockData extends DataTableSource {
  final List<StokModel> data;

  StockData({required this.data});

  @override
  DataRow? getRow(int index) {
    int i = 1;
    int number = i++;
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      cells: [
        DataCell(Center(
            child: Text(item.id.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(item.namaProduk.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(item.satuan.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(item.stok_awal.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(
          "+${item.stok_masuk}",
          style: greenTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "-${item.stok_keluar}",
          style: redTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          item.stok_akhir.toString(),
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        )))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
