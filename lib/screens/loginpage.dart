import 'package:flutter/material.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: LoginPageInputField()
    );
  }
}

class LoginPageInputField extends StatefulWidget {
  const LoginPageInputField({super.key});

  @override
  State<LoginPageInputField> createState() => LoginPageInputFieldState();
}

class LoginPageInputFieldState extends State<LoginPageInputField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('Login')
        ],
      )
    );
  }
}