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
  String username = '';
  List<CategoryModel> categoryList = [];
  List<ProductModel> productlist = [];
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
                  onPressed: () {},
                  child: SizedBox(height: 120,width: 120,child: Image.asset("assets/images/${e.toString()}"))),
                )
              ).toList(),
            )
          )
        ],
      )
    ),
    bottomNavigationBar:BottomNavigationBar(items: const <BottomNavigationBarItem>[ 
    BottomNavigationBarItem(icon: Icon(Icons.person),label: 'profile'),
    BottomNavigationBarItem(icon: Icon(Icons.shop),label: 'Order')
    ],
    onTap: (x) {
      if(x == 0)
      {
        //Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfilePageRoute))
      }
      if(x == 1)
      {
        //Navigator.push(context,MaterialPageRoute(builder: (context) => const OrderPageRoute))
      }
    }));
  }
}