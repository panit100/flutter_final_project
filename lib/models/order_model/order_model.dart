import 'package:final_project/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.product,
    required this.status,
    required this.qty,
  });

  String payment;
  String status;

  ProductModel product;
  double totalPrice;
  String orderId;
  int qty;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        product: ProductModel.fromJson(json["product"]),
        totalPrice: json["totalPrice"],
        status: json["status"],
        payment: json["payment"],
        qty: int.parse(json["qty"]));
  }
}
