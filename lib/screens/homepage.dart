import 'package:final_project/screens/login.dart';
import 'package:final_project/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomePageButton());
  }
}

class HomePageButton extends StatefulWidget {
  const HomePageButton({super.key});

  @override
  State<HomePageButton> createState() => HomePageButtonState();
}

class HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: CircleAvatar(
            radius: 80,
            backgroundImage: Image.asset('assets/icons/Logo.png').image,
            backgroundColor: Colors.white,
          )),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
              child: Center(
                  child: Text('Liberate Goods Shop',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'supermarket')))),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              onPressed: (() {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const LoginRoute()));
              }),
              child: const SizedBox(
                width: 250,
                child: Center(
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'supermarket'),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              onPressed: (() {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const SignUpRoute()));
              }),
              child: const SizedBox(
                width: 250,
                child: Center(
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'supermarket'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
