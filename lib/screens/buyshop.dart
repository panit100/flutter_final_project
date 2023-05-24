import 'package:final_project/models/category_model/category_model.dart';
import 'package:final_project/models/product_model/product_model.dart';
import 'package:final_project/screens/catagory.dart';
import 'package:final_project/screens/favoritepage.dart';
import 'package:final_project/screens/orderpage.dart';
import 'package:final_project/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class BuyShopRoute extends StatefulWidget {
  final String currentUsername;
  const BuyShopRoute({super.key,required this.currentUsername});

  @override
  State<BuyShopRoute> createState() => BuyShopPageState();
}

String _localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000/';
  else // for iOS simulator
    return 'http://localhost:3000/';
}

class BuyShopPageState extends State<BuyShopRoute> {
  String username = '';
  List<CategoryModel> categoryList = [];

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

    categoryList = categories;
  }

  @override
  void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
      username = widget.currentUsername;
      await this.getCategoryList();

      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(scrollDirection: Axis.vertical,child: Column(
      children:[
        const SizedBox(
          height: 70,
        ),
        SizedBox(
          width: 350,
          child: Padding(padding: const EdgeInsets.only(left: 30),
          child: Text('Hi, $username',style: const TextStyle(fontSize: 20),) ),
        ),
        const SizedBox(
          height: 25
        ),
        const Text('Category',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Wrap(
            spacing: 20,
            runSpacing: 16,
            children: categoryList.map(
                  (e) => Padding(
                  padding: const EdgeInsets.only(left: 0,top: 10,bottom: 0),
                  child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => CatagoryPage(itemID: e.id,userID: username,currentUsername: 'kuy',)));
                  },
                  child: SizedBox(height: 120,width: 120,child: Image.asset("assets/images/${e.image.toString()}"))),
                )
              ).toList(),
            )
          )
        ],
      )
    ),
    bottomNavigationBar:BottomNavigationBar(items: const <BottomNavigationBarItem>[ 
    BottomNavigationBarItem(icon: Icon(Icons.person),label: 'profile'),
    BottomNavigationBarItem(icon: Icon(Icons.star,color: Colors.yellow,),label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.shop),label: 'Order')
    ],
    onTap: (x) {
      if(x == 0)
      {
        Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileRoute(currentUsername: widget.currentUsername)));
      }
      if(x == 1)
      {
        Navigator.push(context,MaterialPageRoute(builder: (context) => FavoritePageRoute(currentUsername: widget.currentUsername)));
      }
      if(x == 2)
      {
        Navigator.push(context,MaterialPageRoute(builder: (context) => OrderPageRoute(currentUsername: widget.currentUsername)));
      }
    }));
  }
}