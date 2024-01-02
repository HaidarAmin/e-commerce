import 'package:flutter/material.dart';
import 'item.dart';
import 'delivery.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF3D4042),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Cart items',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFDD5638),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  cartItems = [];
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Center(
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) => Column(children: [
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.all(5),
                        width: width * 0.9,
                        child: Row(children: [
                          SizedBox(width: width * 0.15),
                          Flexible(
                              child: Text(cartItems[index].toString(),
                                  style: TextStyle(
                                      fontSize: width * 0.025,
                                      color: const Color(0xFFEE9C45)))),
                        ]))
                  ]))),
      floatingActionButton: FittedBox(
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFFEE9C45),
          onPressed: () {
            setState(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Delivery()));
            });
          },
          label: const Text(
            'Head to checkout',
            style: TextStyle(fontSize: 20, color: Color(0xFF3D4042)),
          ),
        ),
      ),
    );
  }
}
