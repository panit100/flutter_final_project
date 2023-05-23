import 'dart:io';

import 'package:final_project/screens/aboutuspage.dart';
import 'package:final_project/screens/homepage.dart';
import 'package:final_project/screens/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Profile')),body: const ProfliePage());
  }
}

class ProfliePage extends StatefulWidget {
  const ProfliePage({super.key});

  @override
  State<ProfliePage> createState() => ProfliePageState();
}

// void switchImage() async {
//   String imagePath = await GetImagePath();
//   print(imagePath);
// }

// Future<String> GetImagePath() {
//   return Future(() => null)
// }

class ProfliePageState extends State<ProfliePage> {
  String? _username;
  String? _email;
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  bool isShow = false;
  void onButtonPress() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Center(
          child: Text(
          'Account',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: CircleAvatar(
          radius: 80,
          backgroundImage: (_image != null)
              ? Image.file(_image!).image
              : Image.asset('assets/images/profileimage.jpg').image,
        )),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: UploadImageButton(title: 'Upload Image', onClick: getImage)),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: UsernameText(
                title:
                    (_username != null) ? _username.toString() : 'Username')),
        Center(
            child: EmailText(
                title: _email != null ? _email.toString() : 'Email@mail.com')),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: ProfileButton(
          buttonIcon: Icons.shopping_bag_outlined,
          buttonTitle: 'Your Order',
          onClick: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderPageRoute()));
          }),
        )),
        const SizedBox(
          height: 10,
        ),
        // Center(
        //     child: ProfileButton(
        //   buttonIcon: Icons.favorite_border_outlined,
        //   buttonTitle: 'Favourite',
        //   onClick: () => {},
        // )),
        // const SizedBox(
        //   height: 10,
        // ),
        Center(
            child: ProfileButton(
          buttonIcon: Icons.info_outline,
          buttonTitle: 'About us',
          onClick: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutusRoute()));
          }),
        )),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: ProfileButton(
          buttonIcon: Icons.logout_outlined,
          buttonTitle: 'Log Out',
          onClick: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Homepage()));
          }),
        )),
        const SizedBox(
          height: 10,
        ),
        // Expanded(
        //   flex: 2,
        //   child: Container(
        //     child: Column(
        //       children: const [
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Your Order'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Favourite'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('About us'),
        //         ),
        //         ListTile(
        //           leading: Icon(Icons.shopping_bag_outlined),
        //           title: Text('Log out'),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Center(child: ProfileText(title: 'Version 1.0.0')),
      ],
      )
    );
  }
}

Widget ProfileButton({
  required String buttonTitle,
  required IconData buttonIcon,
  required VoidCallback onClick,
}) {
  return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(width: 0, color: Colors.white),
              shadowColor: Colors.grey),
          onPressed: onClick,
          child: SizedBox(
            width: 350,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(buttonIcon),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  buttonTitle,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          )));
}

Widget ProfileText({required String title}) {
  return Text(
      title,
      style: const TextStyle(fontSize: 15),
  );
}

Widget UsernameText({required String title}) {
  return Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
}

Widget EmailText({required String title}) {
  return Text(
      title,
      style: const TextStyle(fontSize: 15),
    );
}

Widget UploadImageButton({
  required String title,
  required VoidCallback onClick,
}) {
  return SizedBox(
      width: 280,
      child: ElevatedButton(
          onPressed: onClick,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(title)
            ],
          )));
}
