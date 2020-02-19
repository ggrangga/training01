import 'dart:convert';

import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network/ws_client.dart';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:demo_app/domain/omdb/entities/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Bind.toType(OmdbRemoteDatasourceImpl)
@injectable
abstract class OmdbRemoteDatasource {
  Future<List<ImageModel>> fetchSearch(String str);
}

@lazySingleton
@injectable
class OmdbRemoteDatasourceImpl implements OmdbRemoteDatasource {
  final MovieClient client;
  final String _omdbHost = 'www.omdbapi.com';

  OmdbRemoteDatasourceImpl({this.client});

  factory OmdbRemoteDatasourceImpl.create() {
    return OmdbRemoteDatasourceImpl(
      client: MovieClientImpl(defaultHttp),
    );
  }

  @override
  Future<List<ImageModel>> fetchSearch(
    String str
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var map = new Map<String, dynamic>();
    str.substring(1).split("&").toList().forEach((value) => map[value.split("=")[0]] = value.split("=")[1]); 
    
    http.Response response = await client.get(Uri.https(_omdbHost, '/', {
      'apikey': token,
      ...map
    }));
    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200 && !jsonBody.containsKey('Error'))
      return (jsonBody['Search'] as List).map((i) => ImageModel.fromJson(i)).toList();
    return [];
  }
}
