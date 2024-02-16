import 'package:flutter/material.dart';

class LR extends StatefulWidget {
  const LR({super.key});

  @override
  State<LR> createState() => _LRState();
}

class _LRState extends State<LR> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login & registrition"),
        ),
      ),
    );
  }
}
