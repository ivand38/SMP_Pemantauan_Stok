import 'package:flutter/material.dart';
import 'package:smp_app/page/daftarpiutang.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/listhutang_model.dart';
import 'package:smp_app/widget/currencyformat.dart';
import 'package:smp_app/models/user_model.dart';

class SalesmanCard extends StatelessWidget {
  final ListHutangModel listHutang;
  SalesmanCard(this.listHutang);

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
              Text(
                listHutang.nama_salesman.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Piutang',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: regular)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(
                        int.parse(listHutang.sisa_utang.toString())),
                    style: blueTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: secondaryTextColor,
            thickness: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DaftarPiutangPage(
                              listHutang.nama_salesman.toString())));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
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
