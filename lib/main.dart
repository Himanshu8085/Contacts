import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Myhome()));
}

class Myhome extends StatelessWidget {
  const Myhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts Manager Test app"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text("Name"),
          SizedBox(
            height: 10,
          ),
          Text("address")
        ]),
      ),
    );
  }
}
