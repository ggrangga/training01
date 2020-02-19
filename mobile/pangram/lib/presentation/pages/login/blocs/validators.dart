import 'dart:async';

class Validators {
  final validateToken = StreamTransformer<String, String>.fromHandlers(
    handleData: (token, sink) async{
      /*if(token == null){
        sink.addError("Incorrect token!");
      }else */if(token.length > 5){
        sink.add(token);
      }else{
        sink.addError("Value at least 6 char");
      }
    }
  );

  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) async{
      sink.add(name);
    }
  );
}