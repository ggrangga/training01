import 'package:flutter/material.dart';

class PangramScreen extends StatefulWidget {
  PangramScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PangramScreen();
}

class _PangramScreen extends State<PangramScreen> {
  Widget build(context) {
    return new Container(
      child: Text("Pangram"),
    );
  }
}