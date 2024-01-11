import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'testingapis1234.000webhostapp.com';

class Item {
  final int _itemid;
  final String _name;
  final int _instock;
  final double _price;
  final String _category;

  Item(this._itemid, this._name, this._instock, this._price, this._category);

  @override
  String toString() {
    return 'ItemID: $_itemid\nName: $_name\nInStock: $_instock\n Price: \$$_price\nCategory: $_category';
  }
  double get price => _price;
}

List<Item> _items = [];
List<Item> cartItems = [];

void updateItems(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getItems.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _items.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Item i = Item(
            int.parse(row['itemid']),
            row['name'],
            int.parse(row['instock']),
            double.parse(row['price']),
            row['category']);
        _items.add(i);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void searchItem(Function(String text) update, int itemid) async {
  try {
    final url = Uri.https(_baseURL, 'searchItem.php', {'itemid': '$itemid'});
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _items.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Item i = Item(
          int.parse(row['itemid']),
          row['name'],
          int.parse(row['instock']),
          double.parse(row['price']),
          row['category']);
      _items.add(i);
      update(i.toString());
    }
  } catch (e) {
    update("can't load data");
  }
}

class ShowItems extends StatelessWidget {
  const ShowItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double totalPrice = 0;
    String ditems = '';
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => Column(children: [
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(5),
                  width: width * 0.9,
                  child: Row(children: [
                    SizedBox(
                      height: height * 0.25,
                      width: width * 0.25,
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image:
                              'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvdGhpbmclMjBzdG9yZXxlbnwwfHwwfHx8MA%3D%3D'),
                    ),
                    SizedBox(width: width * 0.15),
                    Flexible(
                        child: Text(_items[index].toString(),
                            style: TextStyle(
                                fontSize: width * 0.025,
                                color: Color(0xFFEE9C45)))),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEE9C45)),
                        onPressed: () {
                          cartItems.add(_items[index]);
                          totalPrice += cartItems[index]._price;
                          ditems += _items[index]._itemid as String;
                        },
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Color(0xFF3D4042),
                          ),
                        ))
                  ]))
            ]));
  }
}
