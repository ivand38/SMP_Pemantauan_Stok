import 'package:collection/collection.dart';

class DetailSalesProdukModel {
  String? nama_salesman;
  String? nama_produk;
  String? stok_keluar;
  String? satuan;
  String? total_omzet;

  DetailSalesProdukModel(
      {this.nama_salesman,
      this.nama_produk,
      this.stok_keluar,
      this.satuan,
      this.total_omzet});

  DetailSalesProdukModel.fromJson(Map<String, dynamic> json) {
    nama_salesman = json['nama_salesman'];
    nama_produk = json['nama_produk'];
    stok_keluar = json['stok_keluar'];
    satuan = json['satuan'];
    total_omzet = json['total_omzet'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': nama_produk,
      'nama_salesman': nama_salesman,
      'stok_keluar': stok_keluar,
      'satuan': satuan,
      'total_omzet': total_omzet
    };
  }
}
