import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smp_app/theme.dart';

class OmzetSalesmanPage extends StatefulWidget {
  const OmzetSalesmanPage({super.key});

  @override
  State<OmzetSalesmanPage> createState() => _OmzetSalesmanPageState();
}

class _OmzetSalesmanPageState extends State<OmzetSalesmanPage> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  // DateTime _dateTime = DateTime.now();
  DateFormat myFormat = DateFormat('dd MMM yyyy');

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
            title: const Text('Data Omzet Salesman'),
            titleTextStyle:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30),
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
                        Text(
                          '${myFormat.format(start)} - ${myFormat.format(end)}',
                          style: purpleTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
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
                    source: OmzetData(context: context),
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

class OmzetData extends DataTableSource {
  final BuildContext context;
  OmzetData({required this.context});
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
