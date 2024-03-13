class OmzetProdukModel {
  String? nama_produk;
  String? total_stok_keluar;
  String? satuan;
  String? total_transaksi;

  OmzetProdukModel({
    this.nama_produk,
    this.total_stok_keluar,
    this.satuan,
    this.total_transaksi,
  });

  OmzetProdukModel.fromJson(Map<String, dynamic> json) {
    nama_produk = json['nama_produk'];
    total_stok_keluar = json['total_stok_keluar'];
    satuan = json['satuan'];
    total_transaksi = json['total_transaksi'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': nama_produk,
      'total_stok_keluar': total_stok_keluar,
      'satuan': satuan,
      'total_transaksi': total_transaksi
    };
  }
}
