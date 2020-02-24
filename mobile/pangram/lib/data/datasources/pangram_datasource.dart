import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:demo_app/data/models/pangram.dart';

@Bind.toType(PangramDatasourceImpl)
@injectable
abstract class PangramDatasource {
  Future<Pangram> getData();
}

@lazySingleton
@injectable
class PangramDatasourceImpl extends PangramDatasource {
  Client client;

  @override
  Future<Pangram> getData() async {
    Pangram pangram;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await client.get(
      'pangram-of-the-day.herokuapp.com/pangram', 
      headers: header
    );
    print('response => ' + response.toString());
    return pangram;
  }
}