import 'package:final_project/screens/profilepage.dart';
import 'package:flutter/material.dart';

class AboutusRoute extends StatelessWidget {
  const AboutusRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AboutusPage());
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
        Center(
            child: Text(
          'About us',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ศศิโรจน์ ทิพทิพากร',
              number: '62120501009',
              imagePath: 'assets/images/jojoe.jpg'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย กิตติพัฒน์ โนนหัวรอ',
              number: '62120501012',
              imagePath: 'assets/images/off.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ทักษ์ดนัย ธาดาภิรมย์',
              number: '62120501016',
              imagePath: 'assets/images/tew.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย พนิต สืบสกุลทอง',
              number: '62120501026',
              imagePath: 'assets/images/cute.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย ธีรวัฒน์ ทองปาน',
              number: '62120501026',
              imagePath: 'assets/images/kei.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Name(
              title: 'นาย กษิดิ์เดช ศรีเสกสรร',
              number: '62120501084',
              imagePath: 'assets/images/naoh.jpg'),
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
