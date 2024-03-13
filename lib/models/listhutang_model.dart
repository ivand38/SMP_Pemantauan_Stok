class ListHutangModel {
  int? id;
  String? nama_salesman;
  String? sisa_utang;

  ListHutangModel({this.id, this.nama_salesman, this.sisa_utang});

  ListHutangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama_salesman = json['nama_salesman'];
    sisa_utang = json['sisa_utang'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nama_salesman': nama_salesman, 'sisa_utang': sisa_utang};
  }
}
