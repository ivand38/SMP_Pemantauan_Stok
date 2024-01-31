import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Data Transaksi'),
          titleTextStyle:
              primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
        backgroundColor: bgColor1,
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
                          child: Text('No. Nota',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Tanggal Transaksi',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Nama Salesman',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Nama Customer',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
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
                          child: Text('No. Batch',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Tanggal Exp.',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Jumlah',
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
                          child: Text('Diskon',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Center(
                          child: Text('Total Harga',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                    ],
                    source: TransaksiData(),
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

class TransaksiData extends DataTableSource {
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
            child: Text("SMP010101",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("23 Januari 2024",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("Budi",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(
          "Apotik Sehat Sekali",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "Milton",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "401401",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "23 Januari 2030",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "40",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "MDS",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "Rp10.000",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "20%",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "Rp8.000",
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
