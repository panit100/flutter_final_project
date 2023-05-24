import 'package:final_project/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class FavoritePageRoute extends StatelessWidget {
  const FavoritePageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: FavoritePagePage()
    );
  }
}

class FavoritePagePage extends StatefulWidget {
  const FavoritePagePage({super.key});

  @override
  State<FavoritePagePage> createState() => FavoritePagePageState();
}

class FavoritePagePageState extends State<FavoritePagePage> {
  String username = '';
  List<ProductModel> userFavoriteList = [];
  List<ProductModel> favoritelist =[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    
      userFavoriteList.add(ProductModel(
      image: "Artbook.png", id: "artbook", name: "Liberate Official Artbook",price: 1000,description: 'off is suck',isFavourite: false
    ));
    userFavoriteList.add(ProductModel(
      image: "Key1.png", id: "artbook", name: "Liberate Official Artbook",price: 1000,description: 'off is suck',isFavourite: true
    ));
      userFavoriteList.map((e) => {
      if(e.isFavourite == true)
      {
        favoritelist.add(e)
      }
    }).toList();
    setState(() {
      
    });
  });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite'),),
      body: SingleChildScrollView(
        child: Column(
          children: favoritelist.map(
                  (e) => Padding(
                  padding: const EdgeInsets.only(left: 0,top: 10,bottom: 0),
                  child: SizedBox(
                    width: 400,
                    height: 150,
                    child: ElevatedButton(
                      style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(Color.fromARGB(141, 172, 172, 172))),
                      onPressed: () {

                      }, 
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                      children: [
                        Image.asset("assets/images/${e.image.toString()}",width: 150,height: 150,),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                          child: Text('Order Name: ${e.name.toString()}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                          Padding(padding: const EdgeInsets.only(left: 20,bottom: 10),
                          child: Text('Price: ${e.price.toString()}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                          ]
                        ),
                        Padding(padding: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: const Icon(Icons.star,color: Colors.yellow,),
                            onPressed: () {

                            },
                          )
                          )
                      ],
                     )
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