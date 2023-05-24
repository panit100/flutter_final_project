// import 'package:final_project/models/order_model/order_model.dart';
import 'package:final_project/screens/catagory.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thesis Game Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Homepage(),
      home: const CatagoryPage(),
    );
  }
}
