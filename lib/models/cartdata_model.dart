class CartDataModel {
  int? id;
  String? nama_produk;
  num? jumlah_keluar;
  String? satuan;
  DateTime? tanggal_kedaluwarsa;
  String? no_batch;
  num? total;
  int? subtotal;
  num? diskon;

  CartDataModel(
      {this.id,
      this.nama_produk,
      this.jumlah_keluar,
      this.satuan,
      this.tanggal_kedaluwarsa,
      this.no_batch,
      this.subtotal,
      this.diskon,
      this.total});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama_produk = json['produk']['nama_produk'];
    jumlah_keluar = json['jumlah_keluar'];
    satuan = json['produk']['satuan'];
    tanggal_kedaluwarsa = DateTime.parse(json['tanggal_kedaluwarsa']);
    no_batch = json['no_batch'];
    subtotal = json['harga_jual'] * json['jumlah_keluar'];
    diskon = json['diskon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_produk': nama_produk,
      'jumlah_keluar': jumlah_keluar,
      'satuan': satuan,
      'tanggal_kedaluwarsa': tanggal_kedaluwarsa,
      'no_batch': no_batch,
      'subtotal': subtotal,
      'diskon': diskon,
      'total': total
    };
  }
}
