class OmzetCustomerModel {
  String? nama_customer;
  String? alamat;
  String? total_harga;

  OmzetCustomerModel({this.nama_customer, this.alamat, this.total_harga});

  OmzetCustomerModel.fromJson(Map<String, dynamic> json) {
    nama_customer = json['nama_customer'];
    alamat = json['alamat'];
    total_harga = json['total_harga'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_customer': nama_customer,
      'alamat': alamat,
      'total_harga': total_harga
    };
  }
}
