import 'dart:convert';

import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network/ws_client.dart';

import 'package:injectable/injectable.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/domain/omdb/entities/image_model.dart';
import 'package:demo_app/domain/favorite/entities/imageDetail_model.dart';
import 'package:demo_app/common/network/enum.dart';

@Bind.toType(FavoriteMovieRemoteDatasourceImpl)
@injectable
abstract class FavoriteMovieRemoteDatasource {
  Future<String> addFavorite(ImageModel thisImageModel, String label, String priority, String radioVal, String rating);
  Future<List<ImageDetailModel>> fetchImageForRecomended();
  Future<List<ImageDetailModel>> fetchImageForFavorite();
  Future<String> deleteFavorite(String id);
}

@lazySingleton
@injectable
class FavoriteMovieRemoteDatasourceImpl
    implements FavoriteMovieRemoteDatasource {
  final MovieClient client;

  FavoriteMovieRemoteDatasourceImpl({this.client});

  factory FavoriteMovieRemoteDatasourceImpl.create() {
    return FavoriteMovieRemoteDatasourceImpl(
      client: MovieClientImpl(defaultHttp),
    );
  }

  @override
  Future<String> addFavorite(ImageModel thisImageModel, String label, String priority, String radioVal, String rating) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = thisImageModel.imdbID;
    map["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
    map["title"] = thisImageModel.title;
    map["year"] = thisImageModel.year;
    map["poster"] = thisImageModel.poster;
    map["label"] = label;
    map["priority"] = int.parse(priority);
    map["viewed"] = radioVal == "Yes";
    map["rating"] = int.parse(rating);

    Map<String, String> header = {'token': token, 'Content-Type': 'application/json'};

    var response = await client.post(
      Enums.chfmsoli4qGetAll, 
      headers: header, 
      body: json.encode(map)
    );
    return response.statusCode.toString();
  }

  @override
  Future<List<ImageDetailModel>> fetchImageForRecomended() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    bool this_isRecomended = prefs.getString('isRecomended') == null ? false : prefs.getString('isRecomended') == "true";
    if(this_isRecomended){
      List<ImageDetailModel> myModels = new List.from(
        await getFromUrl(token, Enums.chfmsoli4qGetRecomended, true))
        ..addAll(await getFromUrl(token, Enums.chfmsoli4qGetAll, false));

      return myModels;
    }
    return [];
  }

  @override
  Future<List<ImageDetailModel>> fetchImageForFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    List<ImageDetailModel> myModels = new List.from(await getFromUrl(token, Enums.chfmsoli4qGetAll, false));
    return myModels;
  }

  Future<List<ImageDetailModel>> getFromUrl(var token, var url, var isRecomended) async{
    List<ImageDetailModel> myModels = [];
    var response = await client.get(url, headers: {'token': token});
    var rs = json.decode(response.body);
    if (response.statusCode == 200) {
      if (rs != null) {
        if(isRecomended == false)
          myModels = (rs as List).map((i) => ImageDetailModel.fromJson(i)).toList();
        else
          myModels.add(ImageDetailModel.fromJson(rs));
      }      
    }
    return myModels;
  }

  Future<String> deleteFavorite(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> header = {'token': token, 'Content-Type': 'application/json'};

    var response = await client.delete(
      Enums.chfmsoli4qGetAll+id, 
      headers: header
    );
    return response.statusCode.toString();
  }
}
