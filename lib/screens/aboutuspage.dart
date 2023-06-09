import 'package:final_project/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AboutusRoute extends StatelessWidget {
  const AboutusRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About Us')),
        body: const AboutusPage());
  }
}

class AboutusPage extends StatefulWidget {
  const AboutusPage({super.key});

  @override
  State<AboutusPage> createState() => AboutusPageState();
}

class AboutusPageState extends State<AboutusPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Center(
            child: Text(
          'About us',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'supermarket'),
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ศศิโรจน์ ทิพทิพากร',
              number: '62120501009',
              imagePath: 'assets/icons/jojoe.jpg'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย กิตติพัฒน์ โนนหัวรอ',
              number: '62120501012',
              imagePath: 'assets/icons/off.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ทักษ์ดนัย ธาดาภิรมย์',
              number: '62120501016',
              imagePath: 'assets/icons/tew.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย พนิต สืบสกุลทอง',
              number: '62120501026',
              imagePath: 'assets/icons/cute.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ธีรวัฒน์ ทองปาน',
              number: '62120501070',
              imagePath: 'assets/icons/kei.jpg'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย กษิดิ์เดช ศรีเสกสรร',
              number: '62120501084',
              imagePath: 'assets/icons/naoh.jpg'),
        ),
      ],
    ));
  }
}

Widget Name(
    {required String title,
    required String number,
    required String imagePath}) {
  return Container(
      child: Column(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: Image.asset(imagePath).image,
      ),
      Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      Text(
        number,
        style: TextStyle(fontSize: 15),
      )
    ],
  ));
}
