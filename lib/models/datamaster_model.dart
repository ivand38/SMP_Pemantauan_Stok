class DataMasterModel {
  int? id;
  String? nama_produk;
  DateTime? tanggal_kedaluwarsa;
  DateTime? tanggal_masuk;
  int? stok_tersisa;
  String? no_batch;
  int? harga;

  DataMasterModel(
      {this.id,
      this.nama_produk,
      this.tanggal_kedaluwarsa,
      this.tanggal_masuk,
      this.stok_tersisa,
      this.no_batch,
      this.harga});

  DataMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama_produk = json['produk']['nama_produk'];
    tanggal_kedaluwarsa = DateTime.parse(json['tanggal_kadaluarsa']);
    tanggal_masuk = DateTime.parse(json['tanggal_masuk']);
    stok_tersisa = json['stok_tersisa'];
    no_batch = json['batch'];
    harga = json['produk']['harga'];
  }

  get dataProduk => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_produk': nama_produk,
      'tanggal_kedaluwarsa': tanggal_kedaluwarsa,
      'tanggal_masuk': tanggal_masuk,
      'stok_tersisa': stok_tersisa,
      'no_batch': no_batch,
      'harga': harga
    };
  }
}
