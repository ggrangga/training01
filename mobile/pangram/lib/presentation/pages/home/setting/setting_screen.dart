import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/common/routes/routes.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<SettingScreen> {
  bool IsRecomended = false;
  void initState() {
    super.initState();
    checkIsRecomended();
  }

  checkIsRecomended() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var r = prefs.getString('isRecomended').toString();
    var trys = true;
    if(r.toString() == "null" || r.toString() == "false"){
      trys = false;
    }

    setState(() {
      IsRecomended = trys;
    });
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(margin: EdgeInsets.only(bottom: 150.0)),
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Recommended"),
                Checkbox(
                  value: IsRecomended,
                  onChanged: (bool value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('isRecomended', value.toString());
                    setState(() {
                      IsRecomended = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(margin: EdgeInsets.only(bottom: 20.0)),
          new Container(
            child: RaisedButton(
              child: Text('Logout!'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("token");
                Navigator.of(context).pushNamed(Routes.login,
                    arguments: 'Go to => Dashboard');
              }
            ),
          ),
        ],
      ),
    );
  }
}