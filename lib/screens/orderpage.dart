import 'package:final_project/models/order_model/order_model.dart';
import 'package:final_project/models/product_model/product_model.dart';
import 'package:final_project/models/userOrder_model/userOrder_model.dart';
import 'package:final_project/screens/buyshop.dart';
import 'package:final_project/screens/profilepage.dart';
import 'package:final_project/screens/favoritepage.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';

String _localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000';
  else // for iOS simulator
    return 'http://localhost:3000';
}

// String _localhost() {
//   return 'http://localhost:3000';
// }

class OrderPageRoute extends StatefulWidget {
  final String currentUsername;
  const OrderPageRoute({super.key, required this.currentUsername});

  @override
  State<OrderPageRoute> createState() => OrderPageRouteState();
}

class OrderPageRouteState extends State<OrderPageRoute> {
  String username = '';
  List<UserOrdersModel> orderlist = [];
  List<OrderModel> currentOrderList = [];

  Future getUserOrderList() async {
    final response = await http.get(Uri.parse("${_localhost()}/getUserOder"));

    List<UserOrdersModel> userOders = [];

    var usersJsonList = json.decode(response.body);

    for (var singleItem in usersJsonList) {
      List<OrderModel> orderList = [];

      for (var order in singleItem["orders"]) {
        orderList.add(OrderModel(
            totalPrice: double.parse(order["totalPrice"].toString()),
            orderId: order["orderId"],
            payment: order["payment"],
            product: ProductModel.fromJson(order["product"]),
            status: order["status"],
            qty: order["qty"]));
      }

      UserOrdersModel item =
          UserOrdersModel(username: singleItem["username"], orders: orderList);

      userOders.add(item);
    }

    orderlist = userOders;

    username = widget.currentUsername;
    for (UserOrdersModel currentUserOrderList in orderlist) {
      if (currentUserOrderList.username == username) {
        currentOrderList = currentUserOrderList.orders;
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await this.getUserOrderList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: 'Shop')
          ],
          selectedLabelStyle:
              TextStyle(fontSize: 15, fontFamily: 'supermarket'),
          unselectedLabelStyle:
              TextStyle(fontSize: 15, fontFamily: 'supermarket'),
          onTap: (x) {
            if (x == 0) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: ProfileRoute(
                          currentUsername: widget.currentUsername)));
            }
            if (x == 1) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: FavoritePageRoute(
                          currentUsername: widget.currentUsername)));
            }
            if (x == 2) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: BuyShopRoute(
                          currentUsername: widget.currentUsername)));
            }
          }),
      appBar: AppBar(
        title: const Text(
          'Order',
          style: TextStyle(fontSize: 30, fontFamily: 'supermarket'),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: currentOrderList
            .map(
              (e) => Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 0),
                  child: Container(
                      color: const Color.fromARGB(141, 172, 172, 172),
                      width: 450,
                      height: 150,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/${e.product.image.toString()}",
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                width: 190,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10, top: 10),
                                          child: Text(
                                              'Order Name: ${e.product.name.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'supermarket'))),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          child: Text(
                                              'Price: ${e.product.price.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'supermarket'))),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          child: Text(
                                              'Total Price: ${(e.product.price * e.qty).toString()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'supermarket'))),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 10),
                                          child: RichText(
                                              text: TextSpan(
                                                  text: 'Status:  ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'supermarket'),
                                                  children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        '${e.status.toString()}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'supermarket',
                                                        color: Color.fromARGB(
                                                            255, 255, 215, 15),
                                                        shadows: [
                                                          Shadow(
                                                              // bottomLeft
                                                              offset: Offset(
                                                                  -1.5, -1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              // bottomRight
                                                              offset: Offset(
                                                                  1.5, -1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              // topRight
                                                              offset: Offset(
                                                                  1.5, 1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              // topLeft
                                                              offset: Offset(
                                                                  -1.5, 1.5),
                                                              color:
                                                                  Colors.black),
                                                        ]))
                                              ])))
                                    ]),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text('X ${e.qty.toString()}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'supermarket')))
                            ],
                          )))),
            )
            .toList(),
      )),
    );
  }
}
