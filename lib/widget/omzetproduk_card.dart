import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/omzetproduk_model.dart';
import 'package:smp_app/widget/currencyformat.dart';

class OmzetProdukCard extends StatelessWidget {
  final OmzetProdukModel omzetProduk;
  OmzetProdukCard(this.omzetProduk);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    omzetProduk.nama_produk.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jumlah Barang',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${omzetProduk.total_stok_keluar} ${omzetProduk.satuan}',
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  )
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('Total Omzet',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular)),
                SizedBox(
                  height: 5,
                ),
                Text(
                  CurrencyFormat.convertToIdr(
                      int.parse(omzetProduk.total_transaksi.toString())),
                  style: blueTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
