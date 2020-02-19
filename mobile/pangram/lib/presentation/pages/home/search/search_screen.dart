import 'package:flutter/material.dart';
import 'package:demo_app/presentation/widget/image_list.dart';

import 'package:demo_app/common/config/injector.dart';
import 'package:demo_app/data/omdb_movie/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/domain/omdb/entities/image_model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<SearchScreen> {
  int counter = 0;
  List<ImageModel> images = [];
  bool typing = false;
  String _movieName;

  final OmdbRemoteDatasource omdbRDS = getIt<OmdbRemoteDatasource>();

  void initState() {
    super.initState();
    setState(() {
      _movieName = "&s=dark&y=2019";
    });
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          SearchBoxPage(
            onSearchTappedCallback: (String movieName) {
              setState(() {
                _movieName = movieName;
              });
            },
          ),
          Container(
            child: FutureBuilder<List<ImageModel>>(
              initialData: images,
              future: omdbRDS.fetchSearch(_movieName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none)
                  return AlertDialog(title: Text('Network Error'));
                if (snapshot.hasData)
                  return ImageList(snapshot.data);
                else if (snapshot.error != null)
                  return ListTile(title: Text('Search Error'));
                else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBoxPage extends StatefulWidget{
  final OnSearchTappedCallback onSearchTappedCallback;

  SearchBoxPage({this.onSearchTappedCallback});

  @override
  SearchBoxState createState()=> SearchBoxState();
}

typedef OnSearchTappedCallback = Function(String);
class SearchBoxState extends State<SearchBoxPage> {
  String textfieldOnlyTitleValue = '';
  String textfieldTitleValue = '';
  String _dropdownYearValue = '2020';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: new TextField(
                decoration: InputDecoration(
                hintText: "Search by Title for 2019...",
              ),
              onChanged: (value) {
                setState(() {
                  textfieldOnlyTitleValue = value; 
                });
              },
            )
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              if (textfieldOnlyTitleValue.length > 0) {
                widget.onSearchTappedCallback("&s=$textfieldOnlyTitleValue&y=2019");
                setState(() {
                  textfieldOnlyTitleValue = "";
                });
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_to_queue,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    textfieldTitleValue = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Search by Title...",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: _dropdownYearValue.toString(),
                                items: <String>['2017', '2018', '2019', '2020'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() => (_dropdownYearValue = value));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  String r = "";
                                  if (textfieldTitleValue.length > 0) 
                                    r += "&s=$textfieldTitleValue";
                                  
                                  if (_dropdownYearValue.length > 0) 
                                    r += "&y=$_dropdownYearValue";
                                  

                                  if (r.length > 0) {
                                    widget.onSearchTappedCallback(r);
                                    setState(() {
                                      textfieldTitleValue = "";
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}