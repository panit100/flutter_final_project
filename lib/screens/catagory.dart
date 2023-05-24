import 'package:final_project/models/product_model/product_model.dart';
import 'package:final_project/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/inputscreen.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CatagoryPage extends StatefulWidget {
  final String itemID;
  final String userID;
  const CatagoryPage({super.key,required this.itemID,required this.userID});

  @override
  State<CatagoryPage> createState() => CatagoryState();
}

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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      await this.getProductList();

      await this.getUserData();

      productList.map((e) => {
        if(e.id == widget.itemID)
        {
          mercendiseImg = e.image,
          mercendiseName = e.name,
          description = e.description,
          price = e.price,
          amount = 1,
          totalPrice = price * amount,
          isFavourite = favIdList.contains(e.id),

          if (isFavourite == false)
          {
          favouriteColor = Colors.grey
          } 
          else 
          {
          favouriteColor = Colors.amber,
          }
        },
        }).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor:const Color.fromARGB(255, 232, 232, 232),
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
                      style: const TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    Text(
                      'TotalPrice ${totalPrice.toString()}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.only(left: 100.0)),
                  buttonNav(context)
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
                      style: const TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      description.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black, fontSize: 15.0),
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
                        style:const TextStyle(color: Colors.black, fontSize: 30.0),
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
                        child:const Icon(Icons.add),
                      )
                    ]),
            ],
          ),
        )
      );
  }
}
