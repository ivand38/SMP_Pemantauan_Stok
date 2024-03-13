import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/models/stok_model.dart';
import 'package:smp_app/providers/stok_provider.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/widget/stok_card.dart';

class StokPage extends StatefulWidget {
  const StokPage({super.key});

  @override
  State<StokPage> createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
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
    await Provider.of<StokProvider>(context, listen: false).getStok();
    setState(() {
      _isLoading = false;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool _isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    StokProvider stokProvider = Provider.of<StokProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: _isSearchClicked
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: primaryTextColor),
                    ),
                  ),
            centerTitle: true,
            title: _isSearchClicked
                ? Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      autofocus: true,
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSearchClicked = !_isSearchClicked;
                                  if (!_isSearchClicked) {
                                    _searchController.clear();
                                  }
                                  searchText = '';
                                });
                              },
                              child: Icon(Icons.arrow_back,
                                  color: secondaryTextColor)),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 20, right: 16, bottom: 12),
                          hintText: 'Cari Nama Barang',
                          hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                          border: InputBorder.none),
                    ),
                  )
                : Text('Data Persediaan Barang',
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold)),
            titleTextStyle:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _isSearchClicked
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearchClicked = !_isSearchClicked;
                          });
                        },
                        icon: const Icon(Icons.search),
                        color: primaryTextColor,
                      ),
              ),
            ]),
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
                  decoration: const BoxDecoration(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: searchText.isEmpty
                          ? stokProvider.stoks
                              .map((stok) => StokCard(stok))
                              .toList()
                          : stokProvider.stoks
                                  .where((element) => element.namaProduk!
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()))
                                  .isNotEmpty
                              ? stokProvider.stoks
                                  .where((element) => element.namaProduk!
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()))
                                  .map((stok) => StokCard(stok))
                                  .toList()
                              : [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/notfound.png',
                                        width: 250,
                                        height: 190,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Oops! Tidak ada hasil',
                                        style: primaryTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Maaf, sepertinya kami tidak dapat menemukan hasil yang sesuai dengan pencarian Anda.',
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 14, fontWeight: regular),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )
                                ]),
                ),
              ),
      ),
    );
  }
}
