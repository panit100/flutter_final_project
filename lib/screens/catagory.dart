import 'package:flutter/material.dart';
import 'package:final_project/widgets/inputscreen.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => CatagoryState();
}

class CatagoryState extends State<CatagoryPage> {
  String mercendiseImg = "Artbook.png";
  String mercendiseName = "Artbook";
  String description =
      "descriptionssssssssssssssssssaaaaaaaaasssssssssssssssssssssssssssssssssssssssssaaaaasssssssssssssssssssssssssdescriptionssssssssssssssssssaaaaaaaaasssssssssssssssssssssssssssssssssssssssssaaaaasssssssssssssssssssssssss";
  int price = 10;
  int amount = 0;
  bool isFavourite = false;
  Color favouriteColor = Colors.grey;

  void IncreaseAmount() {
    setState(() {
      if (amount < 99) {
        amount++;
      }
    });
  }

  void DecreaseAmount() {
    setState(() {
      if (amount > 0) {
        amount--;
      }
    });
  }

  void CheckFavourite() {
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
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 232, 232, 232),
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            FloatingActionButton(
              backgroundColor:
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0),
              elevation: 0.0,
              onPressed: () {
                // Back Icon Pressed Action
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 240.0)),
            FloatingActionButton(
              backgroundColor:
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0),
              elevation: 0.0,
              onPressed: () {
                CheckFavourite();
              },
              child: Icon(Icons.star, color: favouriteColor),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 30.0)),
                  Column(children: [
                    Text(
                      "  Price",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    Text(
                      "\$${price * amount}",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ]),
                  Padding(padding: const EdgeInsets.only(left: 180.0)),
                  buttonNav(context),
                ]),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/${mercendiseImg}",
                width: 250,
              ),
              new Container(
                padding: const EdgeInsets.all(16.0),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: new Column(
                  children: <Widget>[
                    Text(
                      "$mercendiseName",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new Text(
                      "$description",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            DecreaseAmount();
                          },
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${amount}",
                          style: TextStyle(color: Colors.black, fontSize: 30.0),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            IncreaseAmount();
                          },
                          child: Icon(Icons.add),
                        )
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}
