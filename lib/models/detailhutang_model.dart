class DetailHutangModel {
  int? id;
  String? nama_salesman;
  String? nama_customer;
  String? alamat;
  String? sisa_utang;

  DetailHutangModel(
      {this.id,
      this.nama_salesman,
      this.nama_customer,
      this.alamat,
      this.sisa_utang});

  DetailHutangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama_salesman = json['nama_salesman'];
    nama_customer = json['nama_customer'];
    alamat = json['alamat'];
    sisa_utang = json['sisa_utang'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_customer': nama_customer,
      'alamat': alamat,
      'nama_salesman': nama_salesman,
      'sisa_utang': sisa_utang
    };
  }
}
