import 'package:final_project/screens/login.dart';
import 'package:flutter/material.dart';

class SignUpRoute extends StatelessWidget {
  const SignUpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignUpInputField());
  }
}

class SignUpInputField extends StatefulWidget {
  const SignUpInputField({super.key});

  @override
  State<SignUpInputField> createState() => SignUpInputFieldState();
}

class SignUpInputFieldState extends State<SignUpInputField> {
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
          height: 100,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: SizedBox(
              width: 700,
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30, top: 10),
          child: SizedBox(
              width: 700,
              child: Text(
                'Please Login or Sign up to our app',
                style: TextStyle(fontSize: 15),
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
            style: TextStyle(fontSize: 10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
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
            style: TextStyle(fontSize: 10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Email',
            style: TextStyle(fontSize: 10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              onPressed: onButtonPress,
              // onPressed: (() {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const LoginRoute()));
              // }),
              child: const SizedBox(
                width: 200,
                child: Text(
                  'SignUp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
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
                    MaterialPageRoute(
                        builder: (context) => const LoginRoute()));
              }),
              child: const SizedBox(
                width: 200,
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
      ],
    );
  }
}
