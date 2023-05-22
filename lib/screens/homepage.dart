import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: HomePageButton()
    );
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
          const SizedBox(
            child: Center(
              child:Text('Liberate Goods Shop'
              ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
              )
            )
          ),
          const SizedBox(
            height: 250,
          ),
          ElevatedButton(
            style: style,
            onPressed: onPressedLogin,
            child: const SizedBox(
                width: 250,
                child: Center(
                  child: Text('Login')
                ),
            ),
          ),
          const SizedBox(height: 20,
          ),
          ElevatedButton(
            style: style,
            onPressed: onPressedSignUp,
            child: const SizedBox(
                width: 250,
                child: Center(
                  child: Text('Sign Up')
                ),
            ),
          ),
        ],
      ),
    );
  }
}

  void onPressedLogin()
  {
    //Redirect here
  }

  void onPressedSignUp()
  {
    //Redirect here
  }
