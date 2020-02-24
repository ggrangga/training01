import 'dart:convert';

import 'package:demo_app/domain/pangram/entities/pangram_entity.dart';

class Pangram extends PangramEntity{
  Pangram({String data}) 
  : super(data : data);

  factory Pangram.fromJson(Map<String, dynamic> json){
    return Pangram(
      data: json['data'],
    );
  }

  factory Pangram.fromJsonDemoApi(Map<String, dynamic> json){
    return Pangram(
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'data' : data,
    };
  }

  String toString(){
    return jsonEncode(toJson());
  }
}
