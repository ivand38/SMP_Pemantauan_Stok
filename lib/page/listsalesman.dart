import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/widget/salesman_card.dart';
import 'package:smp_app/models/listhutang_model.dart';
import 'package:smp_app/providers/listhutang_provider.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/models/user_model.dart';

class ListSalesmanPage extends StatefulWidget {
  const ListSalesmanPage({super.key});

  @override
  State<ListSalesmanPage> createState() => _ListSalesmanPageState();
}

class _ListSalesmanPageState extends State<ListSalesmanPage> {
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
    await Provider.of<ListHutangProvider>(context, listen: false)
        .getListHutang();
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
    ListHutangProvider listHutangProvider =
        Provider.of<ListHutangProvider>(context);
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
                        hintText: 'Cari Nama Salesman',
                        hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                        border: InputBorder.none),
                  ),
                )
              : Text('List Salesman',
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
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: bgColor3,
              ))
            : SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 30, top: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: searchText.isEmpty
                            ? listHutangProvider.listHutangs.isEmpty
                                ? [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/data_notfound.png',
                                          width: 250,
                                          height: 190,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Tidak ada hutang saat ini',
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: semiBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Saat ini tidak ada hutang yang terdaftar pada perusahaan. Hubungi admin jika terjadi kesalahan data.',
                                          style: secondaryTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: regular),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )
                                  ]
                                : listHutangProvider.listHutangs
                                    .map((listHutang) =>
                                        SalesmanCard(listHutang))
                                    .toList()
                            : listHutangProvider.listHutangs
                                    .where((element) => element.nama_salesman!
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()))
                                    .isNotEmpty
                                ? listHutangProvider.listHutangs
                                    .where((element) => element.nama_salesman!
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()))
                                    .map((listHutang) => SalesmanCard(
                                          listHutang,
                                        ))
                                    .toList()
                                : [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                              fontSize: 16,
                                              fontWeight: semiBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Maaf, sepertinya kami tidak dapat menemukan hasil yang sesuai dengan pencarian Anda.',
                                          style: secondaryTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: regular),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )
                                  ])),
              ),
      ),
    );
  }
}
