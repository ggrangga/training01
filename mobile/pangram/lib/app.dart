import 'package:demo_app/common/routes/router.dart';
//import 'package:demo_app/presentation/pages/splash/splash_page.dart';
import 'package:demo_app/presentation/pages/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Omdb App',
      home: LoginScreen(),
      //onGenerateRoute: Router.onGenerateRoute,
      routes: Router.routes,
    );
  }
}