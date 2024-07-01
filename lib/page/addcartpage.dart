import 'package:flutter/material.dart';
import 'package:smp_app/models/cartdata_model.dart';
import 'package:smp_app/models/datamaster_model.dart';
import 'package:smp_app/providers/cart_provider.dart';
import 'package:smp_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({super.key});

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<CartProvider>(context, listen: false).getMaster();
  }

  @override
  TextEditingController produkController = TextEditingController(text: '');
  TextEditingController batchController = TextEditingController(text: '');
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController jumlahBarangController =
      TextEditingController(text: '');
  TextEditingController diskonBarangController =
      TextEditingController(text: '');
  String selectedCategory = '';
  String actualCategory = '';
  TextEditingController hargaJualController = TextEditingController(text: '');
  DateFormat format1 = DateFormat('dd MMM yyyy');
  DateFormat format2 = DateFormat('yyyy-MM-dd');
  List<DataMasterModel>? dataMaster;
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    handleAddCart() async {
      if (await cartProvider.addCart(
          produk_id: actualCategory,
          no_batch: batchController.text,
          tanggal_kedaluwarsa: dateCtrl.text,
          jumlah_keluar: jumlahBarangController.text,
          diskon: diskonBarangController.text,
          harga_jual: hargaJualController.text)) {
        Navigator.pushNamed(context, '/addtransaksipage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Menambah Barang',
              textAlign: TextAlign.center,
            )));
      }
    }

    Widget nomorBatchInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nomor Batch',
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
                    controller: batchController,
                    decoration: InputDecoration(
                      hintText: 'No Batch',
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

    Widget tanggalExpiredInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tanggal Kadaluarsa',
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
                      dateCtrl.text = format2.format(date!).toString();
                    },
                    style: primaryTextStyle,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month, color: bgColor3),
                      hintText: 'Tanggal Kadaluarsa',
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

    Widget namaProdukInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Produk',
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
              child: Column(
                children: [
                  Expanded(
                    child: DropdownButton(
                      items: cartProvider.datas.map((e) {
                        return DropdownMenuItem(
                            value: e.id.toString() +
                                ' | ' +
                                e.nama_produk.toString() +
                                ' | No Batch: ' +
                                e.no_batch.toString() +
                                ' | Tgl. Masuk: ' +
                                format1.format(e.tanggal_masuk!).toString() +
                                ' | Stok: ' +
                                e.stok_tersisa.toString() +
                                ' | Harga: ' +
                                e.harga.toString(),
                            child: Text(
                              e.id.toString() +
                                  ' | ' +
                                  e.nama_produk.toString(),
                            ));
                      }).toList(),
                      hint: Text(
                        selectedCategory.isEmpty
                            ? 'Pilih Produk'
                            : selectedCategory,
                        style: primaryTextStyle.copyWith(fontSize: 12),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox(),
                      isExpanded: true,
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            selectedCategory = value;
                            actualCategory = value[0];
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

    Widget diskonBarangInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Diskon Barang (%)',
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
                    controller: diskonBarangController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Diskon Barang (%)',
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

    Widget jumlahBarangInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jumlah Barang',
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
                    controller: jumlahBarangController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Jumlah Barang',
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

    Widget hargaJualInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Harga Jual',
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
                    controller: hargaJualController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Harga Jual',
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

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Tambah Barang',
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
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              namaProdukInput(),
              SizedBox(height: 20),
              nomorBatchInput(),
              SizedBox(height: 20),
              tanggalExpiredInput(),
              SizedBox(height: 20),
              jumlahBarangInput(),
              SizedBox(height: 20),
              diskonBarangInput(),
              SizedBox(height: 20),
              hargaJualInput(),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  handleAddCart();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: bgColor3, borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    'Tambah Barang',
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
