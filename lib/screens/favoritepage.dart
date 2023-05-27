import 'package:final_project/models/product_model/product_model.dart';
import 'package:final_project/models/user_model/user_model.dart';
import 'package:final_project/screens/catagory.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/profilepage.dart';
import 'package:final_project/screens/orderpage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class FavoritePageRoute extends StatefulWidget {
  final String currentUsername;
  const FavoritePageRoute({super.key, required this.currentUsername});

  @override
  State<FavoritePageRoute> createState() => FavoritePagePageState();
}

// String _localhost() {
//   return 'http://localhost:3000';
// }

String _localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000';
  else // for iOS simulator
    return 'http://localhost:3000';
}

class FavoritePagePageState extends State<FavoritePageRoute> {
  List<ProductModel> userFavoriteList = [];
  List<ProductModel> productList = [];
  UserModel userData = UserModel(id: '', name: '', email: '', favouriteIds: '');

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
        'username': widget.currentUsername,
      }),
    );

    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    UserModel userData = UserModel(
        id: responseData["0"]["id"].toString(),
        name: responseData["0"]["username"],
        email: responseData["0"]["email"],
        favouriteIds: responseData["0"]["favIds"]);

    String password = responseData["0"]["password"];

    if (userData.favouriteIds != null) {
      String favIds = userData.favouriteIds.toString();
      favIds.split(',');

      for (ProductModel currentProduct in productList) {
        if (favIds.contains(currentProduct.id)) {
          userFavoriteList.add(currentProduct);
        }
      }
    }

    return userData;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProductList();
      userData = await getUserData();
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
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Order')
          ],
          onTap: (x) {
            if (x == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileRoute(
                          currentUsername: widget.currentUsername)));
            }
            if (x == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPageRoute(
                          currentUsername: widget.currentUsername)));
            }
          }),
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: userFavoriteList
            .map(
              (e) => Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 0),
                  child: SizedBox(
                      width: 400,
                      height: 150,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(141, 172, 172, 172))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => CatagoryPage(
                                    currentUsername: widget.currentUsername,
                                    itemID: e.id))));
                          },
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/${e.image.toString()}",
                                    width: 100,
                                    height: 100,
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 10, top: 10),
                                            child: Text(
                                                'Order Name: ${e.name.toString()}',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 10),
                                            child: Text(
                                                'Price: ${e.price.toString()}',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ]),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        onPressed: () {},
                                      ))
                                ],
                              ))))),
            )
            .toList(),
      )),
    );
  }
}
