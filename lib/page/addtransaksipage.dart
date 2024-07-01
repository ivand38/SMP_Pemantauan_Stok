import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smp_app/models/cartdata_model.dart';
import 'package:smp_app/providers/cart_provider.dart';
import 'package:smp_app/services/cart_service.dart';
import 'package:smp_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/widget/currencyformat.dart';

class AddTransaksiPage extends StatefulWidget {
  const AddTransaksiPage({super.key});

  @override
  State<AddTransaksiPage> createState() => _AddTransaksiPageState();
}

class _AddTransaksiPageState extends State<AddTransaksiPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CartProvider>(context, listen: false).getCart();
    setState(() {
      _isLoading = false;
    });
  }

  deleteCart() async {}

  @override
  TextEditingController kodeController = TextEditingController(text: '');
  TextEditingController diskonController = TextEditingController(text: '0');
  TextEditingController produkController = TextEditingController(text: '');
  TextEditingController totalController = TextEditingController(text: '');
  TextEditingController dateCtrl = TextEditingController();
  String selected1Category = '';
  String perantara = '';
  String selectedCategory = '';
  DateFormat myFormat = DateFormat('yyyy-MM-dd');
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List total_cart =
        cartProvider.carts.map((e) => int.parse(e.total.toString())).toList();
    num sum_total = total_cart.fold(0, (a, b) => a + b);

    handleAddTransaksi() async {
      if (await cartProvider.addTransaksi(
          kode_transaksi: kodeController.text,
          tanggal_transaksi: dateCtrl.text,
          subtotal: int.tryParse(sum_total.toString()),
          diskon: diskonController.text,
          total: int.tryParse(sum_total.toString() *
              ((100 - int.parse(diskonController.text)) / 100).toInt()),
          customer_id: selected1Category,
          metode: selectedCategory,
          bayar: totalController.text)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homepage', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Menambah Barang',
              textAlign: TextAlign.center,
            )));
      }
    }

    Widget kodeTransaksiInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kode Transaksi',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    style: primaryTextStyle,
                    controller: kodeController,
                    decoration: InputDecoration(
                      hintText: 'Kode Transaksi',
                      hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget tanggalTransaksiInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tanggal Transaksi',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: dateCtrl,
                    onTap: () async {
                      DateTime? date = DateTime(2024);
                      FocusScope.of(context).requestFocus(FocusNode());
                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2029),
                      );
                      dateCtrl.text = myFormat.format(date!).toString();
                    },
                    style: primaryTextStyle,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month, color: bgColor3),
                      hintText: 'Tanggal Transaksi',
                      hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget namaCustomerInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Customer',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      items: <String>['1 | Kfarma', '2 | KSehat']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(selected1Category.isEmpty
                          ? 'Nama Customer'
                          : perantara),
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox(),
                      isExpanded: true,
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            selected1Category = value[0];
                            perantara = value;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget diskonTotalInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Diskon Total (%)',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    style: primaryTextStyle,
                    controller: diskonController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Diskon Total (%)',
                      hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget metodeInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Metode Pembayaran',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      items: <String>['Cash', 'Tempo'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(selectedCategory.isEmpty
                          ? 'Metode Pembayaran'
                          : selectedCategory),
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox(),
                      isExpanded: true,
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget totalBayarInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Bayar (Rp)',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    style: primaryTextStyle,
                    controller: totalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Total Bayar',
                      hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget deleteCartButton(String id) {
      return GestureDetector(
        onTap: () async {
          bool response = await CartProvider().deleteCart(id);
          getInit();
        },
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              color: redTextColor, borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Icon(Icons.delete, color: Colors.white, size: 16),
          ),
        ),
      );
    }

    Widget cartCard(final CartDataModel cartData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartData.nama_produk.toString(),
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      cartData.jumlah_keluar.toString() +
                          ' ' +
                          cartData.satuan.toString(),
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                    ),
                    SizedBox(width: 5),
                    deleteCartButton(cartData.id.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Exp Date: ${myFormat.format(cartData.tanggal_kedaluwarsa!)}',
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: regular),
            ),
            Text(
              'No Batch: ${cartData.no_batch}',
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: regular),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  CurrencyFormat.convertToIdr(cartData.total),
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                if (cartData.diskon! > 0)
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        CurrencyFormat.convertToIdr(cartData.subtotal),
                        style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                            decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blueShadeColor),
                          child: Text(cartData.diskon.toString() + '%',
                              style: blueTextStyle.copyWith(
                                  fontSize: 14, fontWeight: regular)),
                        ),
                      )
                    ],
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ])
        ],
      );
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Tambah Transaksi',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: primaryTextColor),
          ),
        ),
      ),
      backgroundColor: bgColor1,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: bgColor3,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 30, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Keranjang',
                        style: primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    Divider(
                      color: secondaryTextColor,
                      thickness: 0.5,
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
                          children: cartProvider.carts.isNotEmpty
                              ? cartProvider.carts
                                  .map((carts) => cartCard(carts))
                                  .toList()
                              : [
                                  Center(
                                    child: Text(
                                      'Data Cart Kosong',
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  )
                                ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Keranjang',
                              style: primaryTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold)),
                          Text(CurrencyFormat.convertToIdr(sum_total),
                              style: blueTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/addcartpage');
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: bgColor3,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          'Tambah Barang',
                          style: whiteTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    kodeTransaksiInput(),
                    SizedBox(
                      height: 20,
                    ),
                    tanggalTransaksiInput(),
                    SizedBox(
                      height: 20,
                    ),
                    namaCustomerInput(),
                    SizedBox(
                      height: 20,
                    ),
                    diskonTotalInput(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Harga',
                              style: primaryTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold)),
                          Text(
                              CurrencyFormat.convertToIdr(sum_total *
                                  (100 - int.parse(diskonController.text)) /
                                  100),
                              style: blueTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    metodeInput(),
                    SizedBox(height: 20),
                    totalBayarInput(),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        handleAddTransaksi();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: bgColor3,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          'Tambah Transaksi',
                          style: whiteTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}
