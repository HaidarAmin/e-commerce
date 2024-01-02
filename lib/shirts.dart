import 'package:flutter/material.dart';
import 'item.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'checkout.dart';

const String _baseURL = 'testingapis1234.000webhostapp.com';

List<Item> _shirts = [];

void updateShirts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getShirts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _shirts.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Item i = Item(
            int.parse(row['itemid']),
            row['name'],
            int.parse(row['instock']),
            double.parse(row['price']),
            row['category']);
        _shirts.add(i);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

class Shirts extends StatefulWidget {
  const Shirts({Key? key}) : super(key: key);

  @override
  State<Shirts> createState() => _ShirtsState();
}

class _ShirtsState extends State<Shirts> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double totalPrice = 0;
    return Scaffold(
        backgroundColor: const Color(0xFF3D4042),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text(
            'Shirts',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFDD5638),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: _shirts.length,
                itemBuilder: (context, index) => Column(children: [
                      const SizedBox(height: 10),
                      Container(
                          padding: const EdgeInsets.all(5),
                          width: width * 0.9,
                          child: Row(children: [
                            SizedBox(width: width * 0.15),
                            Flexible(
                                child: Text(_shirts[index].toString(),
                                    style: TextStyle(
                                        fontSize: width * 0.025,
                                        color: const Color(0xFFEE9C45)))),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFEE9C45)),
                                onPressed: () {
                                  cartItems.add(_shirts[index]);
                                },
                                child: const Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Color(0xFF3D4042),
                                  ),
                                ))
                          ]))
                    ]))));
  }
}
