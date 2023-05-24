import 'package:final_project/screens/catagory.dart';
import 'package:final_project/screens/orderpage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_final_project/lib/widgets/grid.dart';
import 'widgets.dart';
import 'gridbuilder.dart';
import 'grid.dart';

class MyInputScreen extends StatelessWidget {
  const MyInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: buttomBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: mainDrawer(context),
      body: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreen createState() => _InputScreen();
}

class _InputScreen extends State<InputScreen> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // activity 1
        ElevatedButton(
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GridRoute()));
            }),
            child: Text("Grid"),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent)),

        ElevatedButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: Text("Go Back"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
            width: 300.0,
            child: TextField(
              controller: mycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number (2-100)',
              ),
            )),
        ElevatedButton(
          onPressed: (() {
            debugPrint(mycontroller.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        showGrid(nProduct: int.parse(mycontroller.text)))));
          }),
          child: Text("OK"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
        // activity 2
        DropdownButtonExample()
      ],
    ));
  }
}

// Widget buttonNav(BuildContext context) {
//   return TextButton(
//       onPressed: (() => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const OrderPageRoute())))),
//       child: Padding(
//         padding: EdgeInsets.all(2.0),
//         child: Text(
//           "Buy",
//           style: TextStyle(
//               fontSize: 15.0,
//               color: Colors.white,
//               backgroundColor: Colors.black),
//         )),
//     style: TextButton.styleFrom(backgroundColor: Colors.black),
//   );
// }

// activity 2
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  final List<String> list =
      List.generate(100, (index) => index.toString()).toList();
  late String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        // ทำให้สมบูรณ์
        setState(() {
          dropdownValue = value!;
          debugPrint(dropdownValue);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      showGrid(nProduct: int.parse(dropdownValue)))));
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
