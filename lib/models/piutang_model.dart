class PiutangModel {
  int? id;
  DateTime? tanggal_bayar;
  int? angsuran;

  PiutangModel({this.id, this.tanggal_bayar, this.angsuran});

  PiutangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tanggal_bayar = DateTime.parse(json['tanggal_bayar']);
    angsuran = json['angsuran'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'tanggal_bayar': tanggal_bayar, 'angsuran': angsuran};
  }
}
