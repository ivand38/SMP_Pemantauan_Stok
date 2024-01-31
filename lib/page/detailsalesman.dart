import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';

class DetailSalesmanPage extends StatefulWidget {
  const DetailSalesmanPage({super.key});
  @override
  State<DetailSalesmanPage> createState() => _DetailSalesmanPageState();
}

class _DetailSalesmanPageState extends State<DetailSalesmanPage>
    with SingleTickerProviderStateMixin {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  // DateTime _dateTime = DateTime.now();
  DateFormat myFormat = DateFormat('dd MMM yyyy');

  late TabController _tabcontroller;
  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Detail Omzet Salesman'),
            titleTextStyle:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profil Salesman',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nama: Ivan Danis',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'ID Salesman: 1',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Nomor Telepon: 082213225619',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                const SizedBox(
                  height: 30,
                ),
                TabBar(
                  labelColor: bgColor3,
                  controller: _tabcontroller,
                  tabs: const [
                    Tab(
                      text: 'Customer',
                    ),
                    Tab(
                      text: 'Produk',
                    )
                  ],
                ),
                SizedBox(
                  height: 680,
                  child: TabBarView(
                    controller: _tabcontroller,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
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
                                  Text(
                                    '${myFormat.format(start)} - ${myFormat.format(end)}',
                                    style: purpleTextStyle.copyWith(
                                        fontSize: 12, fontWeight: medium),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Theme(
                            data: tableTheme,
                            child: PaginatedDataTable(
                              headingRowColor: MaterialStatePropertyAll(
                                  Colors.grey.shade300),
                              rowsPerPage: 10,
                              columnSpacing: 20,
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
                                    child: Text('ID Produk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Produk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Harga',
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
                                    child: Text('Barang Masuk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Barang Keluar',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Stok Final',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                ))
                              ],
                              source: CustData(context: context),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
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
                                  Text(
                                    '${myFormat.format(start)} - ${myFormat.format(end)}',
                                    style: purpleTextStyle.copyWith(
                                        fontSize: 12, fontWeight: medium),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Theme(
                            data: tableTheme,
                            child: PaginatedDataTable(
                              headingRowColor: MaterialStatePropertyAll(
                                  Colors.grey.shade300),
                              rowsPerPage: 10,
                              columnSpacing: 20,
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
                                    child: Text('ID Produk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Produk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Harga',
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
                                    child: Text('Barang Masuk',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Barang Keluar',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                )),
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                    child: Text('Stok Final',
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        )),
                                  ),
                                ))
                              ],
                              source: ProductData(context: context),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
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
    });
  }
}

class CustData extends DataTableSource {
  final BuildContext context;
  CustData({required this.context});
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Center(
            child: Text("1",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("A-001",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(onTap: () {
          Navigator.pushNamed(context, '/detailsalesman');
        },
            Center(
                child: Text("Nasi Goreng",
                    style: dottedTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("Rp. 10.000",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(
          "0",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "+100",
          style: greenTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "-80",
          style: redTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "20",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}

class ProductData extends DataTableSource {
  final BuildContext context;
  ProductData({required this.context});
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Center(
            child: Text("1",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("A-001",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(onTap: () {
          Navigator.pushNamed(context, '/detailsalesman');
        },
            Center(
                child: Text("Nasi Goreng",
                    style: dottedTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("Rp. 10.000",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(
          "0",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "+100",
          style: greenTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "-80",
          style: redTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "20",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
