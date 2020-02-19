import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:demo_app/common/network/enum.dart';

class Bloc extends Object with Validators{
//class Bloc{
  final _token = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();  

  //add to stream
  Stream<String> get token => _token.stream.transform(validateToken);
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<bool> get submitValid => Observable.combineLatest2(token, name, (t, n) => true);

  /*final tokenController = StreamController<String>();
  get changeTokenController => tokenController.sink.add;
  get myToken => tokenController.stream;*/

  //change
  Function(String) get changeToken => _token.sink.add;
  Function(String) get changeName => _name.sink.add;

  //get
  get myToken => _token.stream;

  submitLogin() async {
    final validToken = _token.value;
    Uri uri = Uri.http(Enums.omdbapi, '/', {
      'apikey': validToken,
      's': 'The Day After Tomorrow'
    });
    var response = await get(uri);
    var rs = json.decode(response.body);
    if (rs['Response'] == "True") {
      return true;
    }
    return false;
  }

  dispose(){
    _token.close();
    _name.close();
  }
}