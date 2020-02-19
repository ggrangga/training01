import 'package:flutter/material.dart';
import 'package:demo_app/domain/omdb/entities/image_model.dart';
import 'package:demo_app/common/config/injector.dart';
import 'package:demo_app/data/favorite_movie/datasources/favorite_remote_datasource.dart';

class MovieDetailScreen extends StatefulWidget {
  final ImageModel imageModel;
  MovieDetailScreen({Key key, @required this.imageModel}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<MovieDetailScreen> {
  bool IsRecomended = false;
  ImageModel thisImageModel;
  TextEditingController _label = new TextEditingController();
  TextEditingController _priority = new TextEditingController();
  TextEditingController _rating = new TextEditingController();
  String _radioValue1;

  final FavoriteMovieRemoteDatasource omdbRDS = getIt<FavoriteMovieRemoteDatasource>();
  
  void initState() {
    super.initState();
    setState(() {
      thisImageModel = widget.imageModel;
      _radioValue1 = "Yes";
      _label.text = thisImageModel.title;
      _priority.text = "1";
      _rating.text = "7";
    });
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Editor"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        child: Flexible(
                          fit: FlexFit.tight,
                          child: new Text(thisImageModel.title + " (" + thisImageModel.year + ")",
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        width: 150.0,
                        height: 200.0,
                        child: Image.network(thisImageModel.poster),
                      ),
                    ],
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                Container(
                  child: TextField(
                    controller: _label,
                    decoration: InputDecoration(
                      hintText: 'Label',
                    ),
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 50.0,
                    child: TextField(
                      controller: _priority,
                      decoration: InputDecoration(
                        hintText: 'Priority',
                      ),
                    ),
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                Container(
                  child: Row(
                    children: <Widget>[
                      new Text(
                        'Viewed :',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      new Radio(
                        value: "Yes",
                        groupValue: _radioValue1,
                        onChanged: radioButtonChanges,
                      ),
                      new Text(
                        'Yes',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: "No",
                        groupValue: _radioValue1,
                        onChanged: radioButtonChanges,
                      ),
                      new Text(
                        'No',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 50.0,
                    child: TextField(
                      controller: _rating,
                      decoration: InputDecoration(
                        hintText: 'Rating',
                      ),
                    ),
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                Container(
                  child: RaisedButton(
                    child: Text('Submit!'),
                    onPressed:() async{
                      var str = await omdbRDS.addFavorite(thisImageModel, _label.text, _priority.text, _radioValue1, _rating.text);
                      str =="200" ? Navigator.pop(context) : null;
                    },
                  )
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}