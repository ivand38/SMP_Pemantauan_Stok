class StokModel {
  int? id;
  String? kode;
  String? namaProduk;
  String? satuan;
  // ignore: non_constant_identifier_names
  int? stok_awal;
  // ignore: non_constant_identifier_names
  int? stok_masuk;
  // ignore: non_constant_identifier_names
  int? stok_keluar;
  // ignore: non_constant_identifier_names
  int? stok_akhir;

  StokModel(
      {this.id,
      this.kode,
      this.namaProduk,
      this.satuan,
      // ignore: non_constant_identifier_names
      this.stok_awal,
      // ignore: non_constant_identifier_names
      this.stok_masuk,
      // ignore: non_constant_identifier_names
      this.stok_keluar,
      // ignore: non_constant_identifier_names
      this.stok_akhir});

  StokModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    namaProduk = json['nama_produk'];
    satuan = json['satuan'];
    stok_awal = json['stok_awal'];
    stok_masuk = json['stok_masuk'];
    stok_keluar = json['stok_keluar'];
    stok_akhir = json['stok_akhir'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'namaProduk': namaProduk,
      'satuan': satuan,
      'stok_awal': stok_awal,
      'stok_masuk': stok_masuk,
      'stok_keluar': stok_keluar,
      'stok_akhir': stok_akhir
    };
  }
}
