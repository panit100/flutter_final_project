import 'package:final_project/models/order_model/order_model.dart';
import 'package:final_project/models/product_model/product_model.dart';
import 'package:final_project/models/userOrder_model/userOrder_model.dart';
import 'package:final_project/models/user_model/user_model.dart';
import 'package:final_project/screens/buyshop.dart';
import 'package:final_project/screens/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/inputscreen.dart';
import 'package:collection/collection.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CatagoryPage extends StatefulWidget {
  final String currentUsername;
  final String itemID;
  final String userID;
  const CatagoryPage(
      {super.key,
      required this.itemID,
      required this.userID,
      required this.currentUsername});

  @override
  State<CatagoryPage> createState() => CatagoryState();
}

// String _localhost() {
//   if (Platform.isAndroid)
//     return 'http://10.0.2.2:3000/';
//   else // for iOS simulator
//     return 'http://localhost:3000/';
// }

String _localhost() {
  return 'http://localhost:3000';
}

class CatagoryState extends State<CatagoryPage> {
  List<ProductModel> productList = [];
  List<String> favIdList = [];
  String mercendiseImg = '';
  String mercendiseName = '';
  String description = '';
  double price = 10;
  int amount = 1;
  double totalPrice = 0;
  bool isFavourite = false;
  Color favouriteColor = Colors.grey;
  List<UserOrdersModel> userOrderList = [];
  String username = '';

  Future getProductList() async {
    final response = await http.get(Uri.parse("${_localhost()}/getProduct"));

    List<ProductModel> products = [];

    var usersJsonList = json.decode(response.body);

    for (var singleItem in usersJsonList) {
      ProductModel item = ProductModel(
          image: singleItem["image"],
          id: singleItem["id"],
          name: singleItem["name"],
          description: singleItem["description"],
          isFavourite: singleItem["isFavourite"],
          price: double.parse(singleItem["price"].toString()),
          qty: singleItem["qty"]);

      products.add(item);
    }

    productList = products;
  }

  Future<UserModel> getUserData() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/getUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': widget.userID,
      }),
    );

    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    UserModel userData = UserModel(
        id: responseData["0"]["id"].toString(),
        name: responseData["0"]["username"],
        email: responseData["0"]["email"],
        favouriteIds: responseData["0"]["favIds"]);

    if (userData.favouriteIds != null) {
      String favIds = userData.favouriteIds.toString();
      favIdList = favIds.split(',');
    }

    return userData;
  }

  void updateOrderList() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/updateUserOder"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userOrderList),
    );
  }

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

    userOrderList = userOders;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await this.getProductList();
      await this.getUserOrderList();
      await this.getUserData();

      productList
          .map((e) => {
                if (e.id == widget.itemID)
                  {
                    mercendiseImg = e.image,
                    mercendiseName = e.name,
                    description = e.description,
                    price = e.price,
                    amount = 1,
                    totalPrice = price * amount,
                    isFavourite = favIdList.contains(e.id),
                    if (isFavourite == false)
                      {favouriteColor = Colors.grey}
                    else
                      {
                        favouriteColor = Colors.amber,
                      }
                  },
              })
          .toList();
      setState(() {});
    });
    super.initState();
  }

  void increaseAmount() {
    setState(() {
      if (amount < 99) {
        amount++;
        totalPrice = amount * price;
      }
    });
  }

  void decreaseAmount() {
    setState(() {
      if (amount > 1) {
        amount--;
        totalPrice = amount * price;
      }
    });
  }

  void checkFavourite() {
    setState(() {
      isFavourite = !isFavourite;
      if (isFavourite == false) {
        favouriteColor = Colors.grey;
      } else {
        favouriteColor = Colors.amber;
      }
    });
  }

  void onPressBuy() async {
    if (userOrderList.firstWhereOrNull(
            (val) => val.username == widget.currentUsername) !=
        null) {
      var userOrder = userOrderList
          .firstWhere((val) => val.username == widget.currentUsername);

      userOrder.orders.add(OrderModel(
          totalPrice: totalPrice,
          orderId: '0',
          payment: 'payment',
          product: ProductModel(
              image: mercendiseImg,
              id: widget.itemID,
              name: mercendiseName,
              price: price,
              description: description,
              isFavourite: isFavourite),
          status: 'Wait for product',
          qty: amount));
    } else {
      List<OrderModel> currentOrder = [];
      currentOrder.add(OrderModel(
          totalPrice: totalPrice,
          orderId: '0',
          payment: 'payment',
          product: ProductModel(
              image: mercendiseImg,
              id: widget.itemID,
              name: mercendiseName,
              price: price,
              description: description,
              isFavourite: isFavourite),
          status: 'Wait for product',
          qty: amount));
      userOrderList.add(UserOrdersModel(
          username: widget.currentUsername, orders: currentOrder));
    }

    updateOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(255, 232, 232, 232),
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.only(left: 245.0)),
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0),
              elevation: 0.0,
              onPressed: () {
                checkFavourite();
              },
              child: Icon(Icons.star, color: favouriteColor),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 30.0)),
                  Column(children: [
                    Text(
                      ('Price ${price.toString()}'),
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    Text(
                      'TotalPrice ${totalPrice.toString()}',
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.only(left: 100.0)),
                  TextButton(
                    onPressed: (() {
                      onPressBuy();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => BuyShopRoute(
                              currentUsername: widget.currentUsername))));
                    }),
                    style: TextButton.styleFrom(backgroundColor: Colors.black),
                    child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Buy",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              backgroundColor: Colors.black),
                        )),
                  )
                ]),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/${mercendiseImg.toString()}',
                width: 250,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 270,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Text(
                      mercendiseName.toString(),
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      description.toString(),
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn2",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        decreaseAmount();
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      amount.toString(),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        increaseAmount();
                      },
                      child: const Icon(Icons.add),
                    )
                  ]),
            ],
          ),
        ));
  }
}
