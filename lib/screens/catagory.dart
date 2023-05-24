import 'package:final_project/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/inputscreen.dart';

class CatagoryPage extends StatefulWidget {
  final String itemID;
  const CatagoryPage({super.key,required this.itemID});

  @override
  State<CatagoryPage> createState() => CatagoryState();
}

class CatagoryState extends State<CatagoryPage> {
  List<ProductModel> productList = [];
  String mercendiseImg = '';
  String mercendiseName = '';
  String description = '';
  double price = 10;
  int amount = 1;
  double totalPrice = 0;
  bool isFavourite = false;
  Color favouriteColor = Colors.grey;

  @override
  void initState() {
    //Get Data From Json
    //productList.add(data);
    productList.add(ProductModel(
      image: 'Artbook.png', 
      id: 'artbook', 
      name: 'Artbook Liberate', 
      price: 1000.0, 
      description: 'หนังสือรวมภาพ illustration จากเกม Liberate สินค้าลิขสิทธิ์แท้จากผู้สร้างโดยตรงภายในจะประกอบไปด้วยรูปภาพภายในเกมรวมไปถึงแนวคิด ภาพร่าง และ หลักการออกแบบตัวละครต่างๆ ภายในเกมที่ไม่สามารถที่จะหาที่ไหนได้อีกแล้ว จำนวน 100 หน้า', isFavourite: false));

      productList.map((e) => {
        if(e.id == widget.itemID)
        {
          mercendiseImg = e.image,
          mercendiseName = e.name,
          description = e.description,
          price = e.price,
          amount = 1,
          totalPrice = price * amount,
          isFavourite = e.isFavourite,
          if (isFavourite == false) {
          favouriteColor = Colors.grey
          } else {
          favouriteColor = Colors.amber,
          }
        },
      }).toList();
    setState(() {
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
