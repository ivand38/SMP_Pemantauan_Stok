class OmzetSalesmanModel {
  String? nama_salesman;
  String? total_harga;

  OmzetSalesmanModel({
    this.nama_salesman,
    this.total_harga,
  });

  OmzetSalesmanModel.fromJson(Map<String, dynamic> json) {
    nama_salesman = json['nama_salesman'];
    total_harga = json['total_harga'];
  }

  Map<String, dynamic> toJson() {
    return {'nama_customer': nama_salesman, 'total_harga': total_harga};
  }
}
