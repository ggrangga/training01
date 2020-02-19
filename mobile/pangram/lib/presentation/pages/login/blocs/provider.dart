import 'package:flutter/material.dart';
import 'bloc.dart';

// class Provider extends InheritedWidget {
//   Provider({Key key, Widget child}) : super(key: key, child: child);

//   bool updateShouldNotify(_) => true;

//   static Bloc of(BuildContext context) {
//     final bloc = Bloc();

//     return bloc;
//   }
// }

class Provider {
  static final Provider instance = Provider._internal();

  factory Provider() {
    return instance;
  }

  Provider._internal();

  Bloc _loginBloc;

  Bloc loginBloc(bool refresh) {
    if (refresh) {
      _loginBloc = Bloc();
    } else {
      _loginBloc ??= Bloc();
    }

    return _loginBloc;
  } 
}