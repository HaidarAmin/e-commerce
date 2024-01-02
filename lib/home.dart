import 'package:e_commerce/hats.dart';
import 'package:e_commerce/pants.dart';
import 'package:e_commerce/shirts.dart';
import 'package:e_commerce/shoes.dart';
import 'package:flutter/material.dart';
import 'item.dart';
import 'search.dart';
import 'checkout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    updateItems(update);
    updateHats(update);
    updateShirts(update);
    updatePants(update);
    updateShoes(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3D4042),
        drawer: Drawer(
          child: Container(
            color: const Color(0xFF3D4042),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFFDD5638),
                    ),
                    child: Center(
                      child: Text(
                        'Selection',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 60,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEE9C45),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Hats()));
                        });
                      },
                      child: const Text(
                        'Hats',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF3D4042)),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEE9C45),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Shirts()));
                        });
                      },
                      child: const Text(
                        'Shirts',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF3D4042)),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEE9C45),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Pants()));
                        });
                      },
                      child: const Text(
                        'Pants',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF3D4042)),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEE9C45),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Shoes()));
                        });
                      },
                      child: const Text(
                        'Shoes',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF3D4042)),
                      )),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFDD5638),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: !_load
                    ? null
                    : () {
                        setState(() {
                          _load = false;
                          updateItems(update);
                          cartItems = [];
                        });
                      },
                icon: const Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                });
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Checkout()));
                  });
                },
                icon: const Icon(Icons.shopping_cart_checkout))
          ],
          title: const Text(
            'Available Items',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: _load
            ? const ShowItems()
            : const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator())));
  }
}
