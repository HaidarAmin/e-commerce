import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'checkout.dart';
import 'item.dart';

const String _baseURL = 'testingapis1234.000webhostapp.com';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  final TextEditingController _controllerID1 = TextEditingController();
  final TextEditingController _controllerID2 = TextEditingController();
  String _name = '';
  String _address = '';
  int did = 1;
  String ditems = '';

  @override
  void dispose() {
    _controllerID1.dispose();
    _controllerID2.dispose();
    super.dispose();
  }

  void update1(String text) {
    setState(() {
      _name = text;
    });
  }

  void update2(String text) {
    setState(() {
      _address = text;
    });
  }

  void addDeliveryToDatabase(
      int did, String _name, String _address, String ditems) async {
    String url = 'https://testingapis1234.000webhostapp.com/addDelivery.php';

    Map<String, dynamic> data = {
      'did': did, // Convert int to string
      'name': _name,
      'address': _address,
      'ditems': ditems,
    };
    var response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Data added successfully to the database')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Failed to add data to the database. Status code: ${response.statusCode}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF3D4042),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Delivery information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFDD5638),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: width * 0.5,
              child: TextField(
                controller: _controllerID1,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: width * 0.5,
              child: TextField(
                controller: _controllerID2,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter your address(city,street,building)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEE9C45)),
                onPressed: () =>
                    addDeliveryToDatabase(did, _name, _address, ditems),
                child: const Text(
                  'Confirm purchase',
                  style: TextStyle(fontSize: 25, color: Color(0xFF3D4042)),
                ))
          ],
        ),
      ),
    );
  }
}
