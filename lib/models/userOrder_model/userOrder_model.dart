import 'package:final_project/models/product_model/product_model.dart';

import '../order_model/order_model.dart';

class UserOrdersModel {
  UserOrdersModel({
    required this.username,
    required this.orders,
  });

  List<OrderModel> orders;
  String username;

  factory UserOrdersModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> orderMap = json["products"];
    return UserOrdersModel(
      username: json["username"],
      orders: orderMap.map((e) => OrderModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "orders": orders,
      };
}
