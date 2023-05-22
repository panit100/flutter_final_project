import 'package:flutter/material.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: LoginPageHeader()
    );
  }
}

class LoginPageHeader extends StatefulWidget {
  const LoginPageHeader({super.key});

  @override
  State<LoginPageHeader> createState() => LoginPageHeaderState();
}

class LoginPageHeaderState extends State<LoginPageHeader> {
    bool isShow = false;
    void onButtonPress()
    {
      setState(() {
        isShow = !isShow;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const SizedBox(
            height: 170,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: SizedBox(
              width: 700,
              child: Text('Welcome',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,)
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30,top: 10),
            child: SizedBox(
              width: 700,
              child: Text('Please Login or Sign up to our app',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,)
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text('Username',
            style: TextStyle(fontSize: 10),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: TextFormField(
              decoration: const InputDecoration(
              hintText: 'Enter Email'
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text('Password',
            style: TextStyle(fontSize: 10),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: TextFormField(
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
              onPressed: onButtonPress, 
              child: const SizedBox(
                width: 200,
                child: Text('Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),),
                )
            ),
          ),
          Visibility(
            visible: isShow,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Text('Error Text',
                textAlign: TextAlign.center,
                ),
              ),
            )    
          )
        ],
      );
  }
}