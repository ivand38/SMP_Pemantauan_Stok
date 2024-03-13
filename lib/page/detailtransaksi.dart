import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/transaksi_model.dart';
import 'package:intl/intl.dart';
import 'package:smp_app/widget/currencyformat.dart';

class DetailTransaksiPage extends StatelessWidget {
  final TransaksiModel transaksi;
  DetailTransaksiPage(this.transaksi, {super.key});
  DateFormat myFormat = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Detail Transaksi'),
        titleTextStyle:
            primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 30),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/aset_detailtransaksi.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          transaksi.nama_customer.toString(),
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          myFormat.format(transaksi.tanggal_transaksi!),
                          style: secondaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tgl Jatuh Tempo',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                myFormat.format(transaksi.jatuh_tempo!),
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Usia Transaksi',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: regular),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${DateTime.now().difference(transaksi.tanggal_transaksi!).inDays} Hari',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                            ],
                          )
                        ])
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: transaksi.status == 'Lunas'
                                    ? greenShadeColor
                                    : redShadeColor),
                            child: Text(transaksi.status.toString(),
                                style: transaksi.status == 'Lunas'
                                    ? greenTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)
                                    : redTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: secondaryTextColor,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nomor Nota',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                        Text(
                          transaksi.kode_transaksi.toString(),
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: secondaryTextColor,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Salesman',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                        Text(
                          transaksi.nama_salesman.toString(),
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              if (transaksi.piutangs!.isNotEmpty)
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Cicilan',
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: transaksi.piutangs!
                              .map((e) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            myFormat.format(e.tanggal_bayar!),
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular),
                                          ),
                                          Text(
                                              CurrencyFormat.convertToIdr(
                                                  e.angsuran),
                                              style: primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: regular))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ]),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Barang',
                        style: primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                      SizedBox(height: 10),
                      Column(
                          children: transaksi.details!
                              .map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.nama_produk.toString(),
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular),
                                          ),
                                          Text(
                                            '${e.stok_keluar} ${e.satuan}',
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Exp Date: ${myFormat.format(e.exp_date!)}',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                      ),
                                      Text(
                                        'No Batch: ${e.no_batch}',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 12, fontWeight: regular),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            CurrencyFormat.convertToIdr(
                                                e.total),
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular),
                                          ),
                                          if (e.diskon! > 0)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      e.subtotal),
                                                  style: secondaryTextStyle
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight: regular,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: blueShadeColor),
                                                    child: Text('${e.diskon}%',
                                                        style: blueTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    regular)),
                                                  ),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ))
                              .toList())
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ringkasan Pembayaran',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular),
                        ),
                        Text(CurrencyFormat.convertToIdr(transaksi.subtotal),
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Diskon',
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular)),
                        Text('${transaksi.diskon_total}%',
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular))
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: secondaryTextColor,
                      thickness: 0.5,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular)),
                        Text(
                            CurrencyFormat.convertToIdr(
                                transaksi.total_transaksi),
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
