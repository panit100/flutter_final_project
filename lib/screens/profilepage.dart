import 'package:final_project/screens/homepage.dart';
import 'package:flutter/material.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProfliePage());
  }
}

class ProfliePage extends StatefulWidget {
  const ProfliePage({super.key});

  @override
  State<ProfliePage> createState() => ProfliePageState();
}

class ProfliePageState extends State<ProfliePage> {
  bool isShow = false;
  void onButtonPress() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 30),
        //   child: SizedBox(
        //       width: 700,
        //       child: Text(
        //         'Account',
        //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.left,
        //       )),
        // ),
        Center(
            child: Text(
          'Account',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/images/profileimage.jpg'),
        )),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'Username',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )),
        Center(
            child: Text(
          'Email@mail.com',
          style: TextStyle(fontSize: 15),
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0, color: Colors.white),
                  shadowColor: Colors.white),
              onPressed: (() {
                onButtonPress();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginRoute())); #Change LoginRoute to BuyShopRoute
              }),
              child: const SizedBox(
                width: 350,
                child: ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'Your Order',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0, color: Colors.white),
                  shadowColor: Colors.white),
              onPressed: (() {
                onButtonPress();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginRoute())); #Change LoginRoute to BuyShopRoute
              }),
              child: const SizedBox(
                width: 350,
                child: ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'Favourite',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0, color: Colors.white),
                  shadowColor: Colors.white),
              onPressed: (() {
                onButtonPress();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginRoute())); #Change LoginRoute to BuyShopRoute
              }),
              child: const SizedBox(
                width: 350,
                child: ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'About us',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0, color: Colors.white),
                  shadowColor: Colors.white),
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Homepage()));
              }),
              child: const SizedBox(
                width: 350,
                child: ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        // Expanded(
        //   flex: 2,
        //   child: Container(
        //     child: Column(
        //       children: const [
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Your Order'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Favourite'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('About us'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Log out'),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Center(
            child: Text(
          'Version 1.0.0',
          style: TextStyle(fontSize: 15),
        )),
      ],
    );
  }
}
