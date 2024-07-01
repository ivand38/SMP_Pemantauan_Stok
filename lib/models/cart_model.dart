import 'cartdata_model.dart';

class CartModel {
  int? total_cart;

  CartModel({this.total_cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    total_cart = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {'total_cart': total_cart};
  }
}
