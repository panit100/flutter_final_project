import 'package:flutter/material.dart';
import 'widgets.dart';

class showGrid extends StatelessWidget {
  const showGrid({super.key, this.nProduct = 20});
  final int nProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: buttomBar(),
      body: gridExample(
        numProduct: nProduct,
      ),
    );
  }
}

class gridExample extends StatefulWidget {
  const gridExample({super.key, this.numProduct = 20});
  final int numProduct;
  @override
  _gridExample createState() => _gridExample();
}

class _gridExample extends State<gridExample> {
  List<Map> myProducts = [{}];

  @override
  void initState() {
    myProducts = List.generate(widget.numProduct,
        (index) => {"id": index, "name": "Product $index"}).toList();
  }

  List _selectedIndexs = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Row(
              children: <Widget>[
                Text(
                    "#number of Blue Box: ${_selectedIndexs.length.toString()}"),
                SizedBox(
                  width: 20,
                ),
                // activity 3
                Text(
                    "#number of Green Box: ${myProducts.length - _selectedIndexs.length}"),
                SizedBox(
                  width: 20,
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.greenAccent,
                    child: IconButton(
                      onPressed: () {
                        debugPrint(myProducts.length.toString());
                        debugPrint(myProducts.toString());

                        setState(() {
                          Map<String, String> dummy = {
                            "id": myProducts.length.toString(),
                            "name": "Product ${myProducts.length}"
                          };
                          myProducts.add(dummy);
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 18.0,
                      ),
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 20,
                ),
                // activity 3
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.greenAccent,
                    child: IconButton(
                      onPressed: () {
                        debugPrint(myProducts.length.toString());
                        // debugPrint(myProducts.toString());

                        setState(() {
                          int checkBox = myProducts.length - 1;
                          if (_selectedIndexs.contains(checkBox)) {
                            _selectedIndexs.remove(checkBox);
                          }
                          myProducts.removeLast();
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        size: 18.0,
                      ),
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 20,
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(top: 120.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  final _isSelected = _selectedIndexs.contains(index);

                  return GestureDetector(
                    onTap: (() {
                      setState(() {
                        if (_isSelected) {
                          _selectedIndexs.remove(index);
                        } else {
                          _selectedIndexs.add(index);
                        }
                      });
                      debugPrint(
                          "color blue: ${_selectedIndexs.length.toString()}");
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _isSelected ? Colors.blue : Colors.green),
                      child: Text(myProducts[index]["name"]),
                    ),
                  );
                }))
      ],
    ));
  }
}
