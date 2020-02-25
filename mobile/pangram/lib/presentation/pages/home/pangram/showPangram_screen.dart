import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PangramScreen extends StatefulWidget {
  PangramScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PangramScreen();
}

class _PangramScreen extends State<PangramScreen> {
  String _textParagraph = '';
  String _value;
  String _TextField1;
  String _TextField2;
  String angramStatus;
  String _TextField3;
  String isogramStatus;

  void fetchPangram() async {
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await http.get('http://pangram-of-the-day.herokuapp.com/pangram', headers: header);
    if (response.statusCode == 200) {
      var _json = json.decode(response.body);
      var data = _json['data'];
      setState(() {
        _textParagraph = data['text'];
      });
    }
  }

  void getAnagram() async{
    if(_TextField1.length > 0 && _TextField2.length > 0){
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["anagram"] = _TextField1.toString().trim();
      map["anagram1"] = _TextField2.toString().trim();
      print(map.toString());
      var response = await http.post(
        'http://pangram-of-the-day.herokuapp.com/anagram', 
        headers: {'Content-Type': 'application/json'}, 
        body: json.encode(map)
      );

      print(' anagram => ' + response.statusCode.toString());
      print(' anagram => ' + response.reasonPhrase.toString());  
      if (response.statusCode == 200) {
        var _json = json.decode(response.body);
        print('status => ' + _json['status'].toString());
        setState(() {
          angramStatus = _json['status'];
        });
      }
    }
  }

  void getIsogram() async{
    if(_TextField3.length > 0){
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["isogram"] = _TextField3.toString().trim();
      var response = await http.post(
        'http://pangram-of-the-day.herokuapp.com/isogram', 
        headers: {'Content-Type': 'application/json'}, 
        body: json.encode(map)
      );

      if (response.statusCode == 200) {
        var _json = json.decode(response.body);
        setState(() {
          isogramStatus = _json['status'];
        });
      }
    }
  }

  void initPage(){
    if(_value== null){
      setState(() {
        isogramStatus = '';
        angramStatus = '';
        _value = 'Pangram';
      });
    } 
  }

  void initState() {
    super.initState();
    fetchPangram();
    initPage();
    print('_value => ' + _value.toString());
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
                alignment: Alignment.center,
                child: new DropdownButton<String>(
                  items: <String>['Pangram', 'Angram', 'Isogram'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  value: _value,
                  isExpanded: true,
                  onChanged: (val) {
                    setState(() {
                      _value = val;
                    });
                  },
                )
              ),
              if(_value.toString()=='Pangram')  _buildPangram(),
              if(_value.toString()=='Angram') _buildAngram(),
              if(_value.toString()=='Isogram')  _buildIsogram(),
              //_value.toString() == 'Pangram' ? _buildPangram() : _buildAngram()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPangram() {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                fetchPangram();
              },
            ),
          ),
          Container(
            child: Text(
              _textParagraph,
              textAlign: TextAlign.left,
            ),
          ),
        ]
      )
    );
  }

   Widget _buildAngram() {
     return new Container(
      child: Column(
        children: <Widget>[
          Container(margin: EdgeInsets.only(bottom: 10.0)),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
                decoration: InputDecoration(
                hintText: "Anagram 1...",
              ),
              onChanged: (value) {
                setState(() {
                  _TextField1 = value;
                });
              },
            )
          ),
          Container(margin: EdgeInsets.only(bottom: 30.0)),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
                decoration: InputDecoration(
                hintText: "Anagram 2...",
              ),
              onChanged: (value) {
                setState(() {
                  _TextField2 = value;
                });
              },
            )
          ),
          Container(margin: EdgeInsets.only(bottom: 10.0)),
          Container(
            child: RaisedButton(
              child: Text('Check!'),
              onPressed: (){
                getAnagram();
              }
            )
          ),
          Container(margin: EdgeInsets.only(bottom: 30.0)),
          Container(
            child: Text(angramStatus)
          )
        ]
      )
    );
   }

   Widget _buildIsogram() {
     return new Container(
      child: Column(
        children: <Widget>[
          Container(margin: EdgeInsets.only(bottom: 10.0)),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
              maxLines: 4,
              decoration: InputDecoration.collapsed(hintText: "Isogram..."),
              onChanged: (value) {
                setState(() {
                  _TextField3 = value;
                });
              },
            )
          ),
          Container(margin: EdgeInsets.only(bottom: 30.0)),
          Container(
            child: RaisedButton(
              child: Text('Check!'),
              onPressed: (){
                getIsogram();
              }
            )
          ),
          Container(margin: EdgeInsets.only(bottom: 30.0)),
          Container(
            child: Text(isogramStatus)
          )
        ]
      )
    );
   }
}