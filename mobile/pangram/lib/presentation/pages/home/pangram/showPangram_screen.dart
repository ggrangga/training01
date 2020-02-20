import 'package:flutter/material.dart';

class PangramScreen extends StatefulWidget {
  PangramScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PangramScreen();
}

class _PangramScreen extends State<PangramScreen> {
  String _textParagraph;
  void initState() {
    super.initState();
    _textParagraph = 'hello world';
  }

  Widget build(context) {
    return new Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      child: SingleChildScrollView(  
        child: new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: new FractionalOffset(0.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10.0)),
              Container(
                child: Text(
                  _textParagraph,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}