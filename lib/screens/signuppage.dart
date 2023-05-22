import 'package:flutter/material.dart';

class SignUpRoute extends StatelessWidget {
  const SignUpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: SignUpInputField()
    );
  }
}

class SignUpInputField extends StatefulWidget {
  const SignUpInputField({super.key});

  @override
  State<SignUpInputField> createState() => SignUpInputFieldState();
}

class SignUpInputFieldState extends State<SignUpInputField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('SignUp')
        ],
      )
    );
  }
}