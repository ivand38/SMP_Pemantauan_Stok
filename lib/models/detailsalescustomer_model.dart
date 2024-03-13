class DetailSalesCustomerModel {
  String? nama_salesman;
  String? nama_customer;
  String? alamat;
  String? total_omzet;

  DetailSalesCustomerModel(
      {this.nama_salesman, this.nama_customer, this.alamat, this.total_omzet});

  DetailSalesCustomerModel.fromJson(Map<String, dynamic> json) {
    nama_salesman = json['nama_salesman'];
    nama_customer = json['nama_customer'];
    alamat = json['alamat'];
    total_omzet = json['total_omzet'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_customer': nama_customer,
      'nama_salesman': nama_salesman,
      'alamat': alamat,
      'total_omzet': total_omzet
    };
  }
}
