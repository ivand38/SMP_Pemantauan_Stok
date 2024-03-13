import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/omzetcustomer_model.dart';
import 'package:smp_app/widget/currencyformat.dart';

class OmzetCustomerCard extends StatelessWidget {
  final OmzetCustomerModel omzetCustomer;
  OmzetCustomerCard(this.omzetCustomer);

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
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    omzetCustomer.nama_customer.toString(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      omzetCustomer.alamat.toString(),
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Omzet',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(
                        int.parse(omzetCustomer.total_harga.toString())),
                    style: blueTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
