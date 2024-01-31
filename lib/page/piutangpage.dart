import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class DaftarPiutangPage extends StatefulWidget {
  const DaftarPiutangPage({super.key});

  @override
  State<DaftarPiutangPage> createState() => _DaftarPiutangPageState();
}

class _DaftarPiutangPageState extends State<DaftarPiutangPage> {
  DateFormat myFormat = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Daftar Piutang'),
            titleTextStyle:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          child: Text('ID Masuk',
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
                          child: Text('Tanggal Masuk',
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
                          child: Text('Jumlah Barang',
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              )),
                        ),
                      )),
                    ],
                    source: PiutangData(),
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

class PiutangData extends DataTableSource {
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
        DataCell(Center(
            child: Text("Milton",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text("23 Januari 2024",
                style: primaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: medium)))),
        DataCell(Center(
            child: Text(
          "23 Januari 2030",
          style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        ))),
        DataCell(Center(
            child: Text(
          "30",
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
