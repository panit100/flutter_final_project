import 'package:final_project/screens/signuppage.dart';
import 'package:final_project/screens/buyshop.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(child: LoginPageHeader()));
  }
}

String _localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000';
  else // for iOS simulator
    return 'http://localhost:3000';
}

// String _localhost() {
//   return 'http://localhost:3000';
// }

class LoginPageHeader extends StatefulWidget {
  const LoginPageHeader({super.key});

  @override
  State<LoginPageHeader> createState() => LoginPageHeaderState();
}

class Item {
  final int? id;
  final String? username;
  final String? password;

  Item({
    this.id,
    this.username,
    this.password,
  });
}

class LoginPageHeaderState extends State<LoginPageHeader> {
  bool isShow = false;
  String username = '';
  String password = '';
  String errorText = '';
  bool isPass = false;
  List<Item> item = [];

  Future<List<Item>> showData() async {
    final response = await http.get(Uri.parse(_localhost() + "/showDB"));

    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<Item> items = [];
    responseData.forEach((index, value) {
      Item item = Item(
          id: value["id"],
          username: value["username"],
          password: value["password"]);
      items.add(item);
    });

    return items;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      item = await showData();

      setState(() {});
    });
    super.initState();
  }

  void onButtonPress(BuildContext context) async {
    item = await showData();

    if (username == '' || password == '') {
      isShow = true;
      errorText = 'Please Enter Username or Password';
    }

    for (Item currentItem in item) {
      if (currentItem.username == username) {
        if (currentItem.password == password) {
          navagatorTo(context);
        } else {
          isShow = true;
          errorText = 'Password is wrong.';
        }
      } else {
        isShow = true;
        errorText = 'This Username does not exist.';
      }
    }

    setState(() {});
  }

  void onPasswordFieldChanged(String value) {
    setState(() {
      password = value;
    });
  }

  void onUsernameFieldChanged(String value) {
    setState(() {
      username = value;
    });
  }

  void navagatorTo(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: BuyShopRoute(currentUsername: username)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 170,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: SizedBox(
              width: 700,
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 40, fontFamily: 'supermarket'),
                textAlign: TextAlign.left,
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30, top: 10),
          child: SizedBox(
              width: 700,
              child: Text(
                'Please Login or Sign up to our app.',
                style: TextStyle(fontSize: 25, fontFamily: 'supermarket'),
                textAlign: TextAlign.left,
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Username',
            style: TextStyle(fontSize: 25, fontFamily: 'supermarket'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            onChanged: (value) {
              onUsernameFieldChanged(value);
            },
            decoration: const InputDecoration(hintText: 'Enter Username'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Password',
            style: TextStyle(fontSize: 25, fontFamily: 'supermarket'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            onChanged: (value) {
              onPasswordFieldChanged(value);
            },
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter Password',
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              onPressed: (() {
                onButtonPress(context);
              }),
              child: const SizedBox(
                width: 200,
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'supermarket'),
                ),
              )),
        ),
        Visibility(
            visible: isShow,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  errorText.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0, color: Colors.white),
                  shadowColor: Colors.white),
              onPressed: (() {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const SignUpRoute()));
              }),
              child: const SizedBox(
                width: 200,
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'supermarket'),
                ),
              )),
        ),
      ],
    );
  }
}
