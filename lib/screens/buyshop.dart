import 'package:final_project/models/category_model/category_model.dart';
import 'package:final_project/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class BuyShopRoute extends StatelessWidget {
  const BuyShopRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: BuyShopRoutePage()
    );
  }
}

class BuyShopRoutePage extends StatefulWidget {
  const BuyShopRoutePage({super.key});

  @override
  State<BuyShopRoutePage> createState() => BuyShopRoutePageState();
}

class BuyShopRoutePageState extends State<BuyShopRoutePage> {
  List<String> test = ["Artbook.png","Key1.png","Key2.png","Key3.png","Key4.png","Manga.png","Artbook.png","Key1.png","Key2.png","Key3.png","Key4.png","Manga.png"];
  String username = '';
  List<CategoryModel> categoryList = [];
  List<ProductModel> productlist = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.vertical,child: Column(
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
            children: test.map(
                  (e) => Padding(
                  padding: const EdgeInsets.only(left: 0,top: 10,bottom: 0),
                  child: ElevatedButton(
                  onPressed: () {},
                  child: SizedBox(height: 120,width: 120,child: Image.asset("assets/icons/${e.toString()}"))),
                )
              ).toList(),
            )
          )
        ],
      )
    );
  }
}