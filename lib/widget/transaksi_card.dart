import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smp_app/page/detailtransaksi.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/transaksi_model.dart';
import 'package:intl/intl.dart';
import 'package:smp_app/widget/currencyformat.dart';

// ignore: must_be_immutable
class TransaksiCard extends StatelessWidget {
  final TransaksiModel transaksi;
  TransaksiCard(this.transaksi, {super.key});
  DateFormat myFormat = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaksi.kode_transaksi.toString(),
                    style: secondaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                  Text(
                    myFormat.format(transaksi.tanggal_transaksi!),
                    style: secondaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  )
                ],
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: secondaryTextColor,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    transaksi.nama_customer.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Text(
                CurrencyFormat.convertToIdr(transaksi.total_transaksi),
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Symbols.person, size: 16),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    transaksi.nama_salesman.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                ],
              ),
              Text('${transaksi.jumlah_item} Item',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Jatuh Tempo',
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    myFormat.format(transaksi.jatuh_tempo!),
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  )
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
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${DateTime.now().difference(transaksi.tanggal_transaksi!).inDays} Hari',
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: secondaryTextColor,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailTransaksiPage(transaksi)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: bgColor3, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Lihat Detail',
                    style: whiteTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
