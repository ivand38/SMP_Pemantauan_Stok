class StokModel {
  int? id;
  String? namaProduk;
  String? satuan;
  int? stok_awal;
  int? stok_masuk;
  int? stok_keluar;
  int? stok_akhir;

  StokModel(
      {this.id,
      this.namaProduk,
      this.satuan,
      this.stok_awal,
      this.stok_masuk,
      this.stok_keluar,
      this.stok_akhir});

  StokModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
      'namaProduk': namaProduk,
      'satuan': satuan,
      'stok_awal': stok_awal,
      'stok_masuk': stok_masuk,
      'stok_keluar': stok_keluar,
      'stok_akhir': stok_akhir
    };
  }
}
