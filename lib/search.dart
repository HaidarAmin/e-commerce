import 'package:flutter/material.dart';
import 'item.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controllerID = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  void getItem() {
    try {
      int itemid = int.parse(_controllerID.text);
      searchItem(update, itemid);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D4042),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFDD5638),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                    controller: _controllerID,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'Enter ID'))),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEE9C45)),
                onPressed: getItem,
                child: const Text('Find',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF3D4042),
                    ))),
            const SizedBox(height: 10),
            Center(
                child: SizedBox(
                    width: 250,
                    child: Flexible(
                        child: Text(
                      _text,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xFFEE9C45)),
                    )))),
          ],
        ),
      ),
    );
  }
}
