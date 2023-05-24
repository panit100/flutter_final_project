import 'package:final_project/models/order_model/order_model.dart';
import 'package:final_project/models/userOrder_model/userOrder_model.dart';
import 'package:final_project/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import '../models/category_model/category_model.dart';
import '../models/product_model/product_model.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter mySQL', home: MyInputScreen());
  }
}

String _localhost() {
  return 'http://localhost:3000';
}

class MyInputScreen extends StatelessWidget {
  const MyInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreen createState() => _InputScreen();
}

//Creating a class to store the data;
class Item {
  final int? id;
  final String? username;
  final String? password;

  Item({
    this.id,
    this.username,
    this.password,
  });
}

class _InputScreen extends State<InputScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  List<UserOrdersModel> userOrderList = [];
  List<String> FavIdList = [];
  Future? serverResponse;
  Future? getUserDataResponse;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //Backend
      await this.getCategoryList();
      await this.getProductList();
      await this.getUserOrderList();

      //Mockup
      // categoriesList.add(CategoryModel(
      //     image: "figure.png", id: "figure", name: "main figure"));
      // categoriesList.add(CategoryModel(
      //     image: "figure.png", id: "figure", name: "main figure"));
      // categoriesList.add(CategoryModel(
      //     image: "figure.png", id: "figure", name: "main figure"));
      setState(() {});
    });
    super.initState();
  }

  Future getCategoryList() async {
    final response = await http.get(Uri.parse("${_localhost()}/getCatalogue"));

    List<CategoryModel> categories = [];

    var usersJsonList = json.decode(response.body);

    for (var singleItem in usersJsonList) {
      CategoryModel item = CategoryModel(
        image: singleItem["image"],
        id: singleItem["id"],
        name: singleItem["name"],
      );

      categories.add(item);
    }

    categoriesList = categories;
  }

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

    productModelList = products;
  }

  void updateProductList() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/updateProduct"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productModelList),
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

  void updateOrderList() async {
    var product = ProductModel(
        image: "figure.png",
        id: "figure2",
        name: "figure2",
        price: 300,
        description: "WTF",
        isFavourite: false);

    var order = OrderModel(
        totalPrice: 250,
        orderId: "0",
        payment: "d",
        product: product,
        status: "status",
        qty: 1);

    List<OrderModel> orders = [];
    orders.add(order);
    orders.add(order);

    var userOrders = UserOrdersModel(username: username.text, orders: orders);
    var userOrderstwo = UserOrdersModel(username: "kei", orders: orders);
    List<UserOrdersModel> userOrderList = [];

    userOrderList.add(userOrders);
    userOrderList.add(userOrderstwo);
    //test

    final response = await http.post(
      Uri.parse(_localhost() + "/updateUserOder"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userOrderList),
    );
  }

  void addData() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/addDB"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'email': email.text,
        'password': password.text,
        'image': "default.png"
      }),
    );
  }

  void updateData() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/updateDB"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'password': newpassword.text
      }),
    );
  }

  void updateFavIds() async {
    //test
    FavIdList.add("figure1");
    FavIdList.add("figure2");

    final response = await http.post(
      Uri.parse(_localhost() + "/updateFavIds"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'favIds': FavIdList.join(',')
      }),
    );

    debugPrint(FavIdList.join(','));
  }

  void deleteData() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/deleteDB"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
      }),
    );
  }

  Future<List<Item>> showData() async {
    final response = await http.get(Uri.parse(_localhost() + "/showDB"));

    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<Item> items = [];
    responseData.forEach((index, value) {
      Item item = Item(
          id: value["id"],
          username: value["username"],
          password: value["password"]);
      items.add(item);
    });

    return items;
  }

  Future<UserModel> getUserData() async {
    final response = await http.post(
      Uri.parse(_localhost() + "/getUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
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
      FavIdList = favIds.split(',');
    }

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            // height: 50,
            color: Colors.amber[500],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: const Center(child: Text('Add Data')),
            ),
          ),
        ),
        Column(children: <Widget>[
          TextField(
            controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint(username.text);
              addData();
            }),
            child: Text("OK"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            // height: 50,
            color: Colors.amber[500],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: const Center(child: Text('Update Data')),
            ),
          ),
        ),
        Column(children: <Widget>[
          TextField(
            controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: newpassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'New Password',
            ),
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint(newpassword.text);
              updateData();
            }),
            child: Text("OK"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            // height: 50,
            color: Colors.amber[500],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: const Center(child: Text('Delete Data')),
            ),
          ),
        ),
        Column(children: <Widget>[
          TextField(
            controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint("delete ${username.text} ");
              deleteData();
            }),
            child: Text("OK"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint("update product");
              updateProductList();
            }),
            child: Text("Update Product"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint("update order");
              updateOrderList();
            }),
            child: Text("Update Order"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (() {
              debugPrint("update FavIds");
              updateFavIds();
            }),
            child: Text("Update FavIds"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            // height: 50,
            color: Colors.amber[500],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: const Center(child: Text('Show Data')),
            ),
          ),
        ),
        // Column(children: <Widget>[
        //   ElevatedButton(
        //     onPressed: (() {
        //       // debugPrint(username.text);
        //       setState(() {
        //         serverResponse = showData();
        //       });
        //     }),
        //     child: Text("Show data"),
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        //   ),
        //   SizedBox(
        //     height: 20,
        //   ),
        // ]),
        Column(children: <Widget>[
          ElevatedButton(
            onPressed: (() {
              // debugPrint(username.text);
              setState(() {
                getUserDataResponse = getUserData();
              });
            }),
            child: Text("Get user data"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
        FutureBuilder(
            future: getUserDataResponse,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("No data"),
                    // child: CircularProgressIndicator(),
                  ),
                );
              } else {
                debugPrint(snapshot.data.toString());
                return Container(
                  child: Center(
                    child: Text(
                        "${snapshot.data.name} ===== ${snapshot.data.favouriteIds}"),
                    // child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
        categoriesList.isEmpty
            ? const Center(
                child: Text("Categories is empty"),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoriesList
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset("assets/images/${e.image}"),
                        ),
                      )
                      .toList(),
                ),
              ),
      ],
    );
  }
}
