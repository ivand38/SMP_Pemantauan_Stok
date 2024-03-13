class DetailTransaksiModel {
  int? id;
  String? nama_produk;
  int? stok_keluar;
  String? satuan;
  DateTime? exp_date;
  String? no_batch;
  int? subtotal;
  int? diskon;
  int? total;

  DetailTransaksiModel(
      {this.id,
      this.nama_produk,
      this.stok_keluar,
      this.satuan,
      this.exp_date,
      this.no_batch,
      this.subtotal,
      this.diskon,
      this.total});

  DetailTransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama_produk = json['produk']['nama_produk'];
    stok_keluar = json['stok_keluar'];
    satuan = json['produk']['satuan'];
    exp_date = DateTime.parse(json['tanggal_kedaluwarsa']);
    no_batch = json['no_batch'];
    subtotal = json['subtotal'];
    diskon = json['diskon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_produk': nama_produk,
      'stok_keluar': stok_keluar,
      'satuan': satuan,
      'exp_date': exp_date,
      'no_batch': no_batch,
      'subtotal': subtotal,
      'diskon': diskon,
      'total': total
    };
  }
}
