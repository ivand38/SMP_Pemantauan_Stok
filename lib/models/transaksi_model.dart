import 'package:smp_app/models/detailtransaksi_model.dart';
import 'package:smp_app/models/piutang_model.dart';

class TransaksiModel {
  int? id;
  String? kode_transaksi;
  DateTime? tanggal_transaksi;
  String? status;
  String? nama_customer;
  String? nama_salesman;
  DateTime? jatuh_tempo;
  int? jumlah_item;
  int? subtotal;
  int? diskon_total;
  int? total_transaksi;
  List<DetailTransaksiModel>? details;
  List<PiutangModel>? piutangs;

  TransaksiModel(
      {this.id,
      this.kode_transaksi,
      this.tanggal_transaksi,
      this.status,
      this.nama_customer,
      this.nama_salesman,
      this.jatuh_tempo,
      this.jumlah_item,
      this.subtotal,
      this.diskon_total,
      this.total_transaksi,
      this.details,
      this.piutangs});

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode_transaksi = json['kode_transaksi'];
    tanggal_transaksi = DateTime.parse(json['tanggal_transaksi']);
    status = json['pembayaran']['status'];
    nama_customer = json['customer']['nama_customer'];
    nama_salesman = json['salesman']['nama_salesman'];
    jatuh_tempo = DateTime.parse(json['pembayaran']['jatuh_tempo']);
    jumlah_item = json['detail_transaksi'].length;
    subtotal = json['subtotal'];
    diskon_total = json['diskon'];
    total_transaksi = json['total'];
    details = json['detail_transaksi']
        .map<DetailTransaksiModel>(
            (detailTransaksi) => DetailTransaksiModel.fromJson(detailTransaksi))
        .toList();
    piutangs = json['pembayaran']['piutang']
            .map<PiutangModel>((piutang) => PiutangModel.fromJson(piutang))
            .toList() ??
        null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_transaksi': kode_transaksi,
      'tanggal_transaksi': tanggal_transaksi,
      'status': status,
      'nama_customer': nama_customer,
      'nama_salesman': nama_salesman,
      'jatuh_tempo': jatuh_tempo,
      'subtotal': subtotal,
      'diskon_total': diskon_total,
      'total_transaksi': total_transaksi,
      'details':
          details?.map((detailTransaksi) => detailTransaksi.toJson()).toList(),
      'piutangs': piutangs?.map((piutang) => piutang.toJson()).toList()
    };
  }
}
