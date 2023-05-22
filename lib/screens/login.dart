import 'package:final_project/screens/signuppage.dart';
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
    String username = '';
    String password = '';
    String errorText = '';
    void onButtonPress()
    {
      setState(() {
        isShow = !isShow;
      });
    }
    void onPasswordFieldChanged(String value)
    {
      setState(() {
        password = value;
      });
    }
    void onUsernameFieldChanged(String value)
    {
      setState(() {
        username = value;
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
              onChanged: (value) {
                onUsernameFieldChanged(value);
              },
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  width: 1,
                  color: Colors.black
                )
              ),
              onPressed: (() {
                onButtonPress();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginRoute())); #Change LoginRoute to BuyShopRoute 
                }
              ),
              child: const SizedBox(
                width: 200,
                child: Text('Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25,color: Colors.black),),
                )
            ),
          ),
          Visibility(
            visible: isShow,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Text(errorText.toString(),
                textAlign: TextAlign.center,
                ),
              ),
            )    
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
                        builder: (context) => const SignUpRoute()));
              }),
              child: const SizedBox(
                width: 200,
                child: Text(
                  "don't have an account? Sign Up",
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