import 'package:final_project/models/order_model/order_model.dart';
import 'package:final_project/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/db_mysql.dart' as database;

class OrderPageRoute extends StatelessWidget {
  const OrderPageRoute({super.key});

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
  List<OrderModel> orderlist = [];
  ProductModel product = ProductModel(
          image: "Artbook.png", id: "artbook", name: "Liberate Official Artbook",price: 1000,description: 'off is suck',isFavourite: false);
  @override
  void initState() {
      orderlist.add(OrderModel(totalPrice: 1000, orderId: '001', payment: '1000', product: product, status: 'Wait for product',qty: 10));
      setState(() {});
      orderlist.add(OrderModel(totalPrice: 1000, orderId: '001', payment: '1000', product: product, status: 'Wait for product',qty: 99));
      setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order'),),
      body: SingleChildScrollView(
        child: Column(
          children: orderlist.map(
                  (e) =>  Padding(
                  padding: const EdgeInsets.only(left: 0,top: 10,bottom: 0),
                  child: Container(
                    color:const Color.fromARGB(141, 172, 172, 172),
                    width: 390,
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                      children: [
                        Image.asset("assets/images/${e.product.image.toString()}",width: 100,height: 100,),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                          child: Text('Order Name: ${e.product.name.toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10),
                          child: Text('Price: ${e.product.price.toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10),
                          child: Text('Total Price: ${(e.product.price * e.qty).toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10),
                          child: Text('Status: ${e.status.toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold)))
                          ]
                        ),
                        Padding(padding: const EdgeInsets.only(left: 10),
                          child: Text('X ${e.qty.toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold)))
                      ],
                     )
                    )
                  )
                ),
              ).toList(),
        )
      ),
    );
  }
}