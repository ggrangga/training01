import 'package:flutter/material.dart';
import 'package:demo_app/domain/favorite/entities/imageDetail_model.dart';
import 'package:demo_app/presentation/widget/imageDetail_list.dart';
import 'package:demo_app/common/config/injector.dart';
import 'package:demo_app/data/favorite_movie/datasources/favorite_remote_datasource.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<FavoriteScreen> {
  List<ImageDetailModel> images = [];
  final FavoriteMovieRemoteDatasource omdbRDS = getIt<FavoriteMovieRemoteDatasource>();

  void fetchImageFavoriteAll() async {
    List<ImageDetailModel> myModels = await omdbRDS.fetchImageForFavorite();
    if (mounted && myModels.length > 0) {
      setState(() {
        images = myModels;
      });
    }
  }

  void initState() {
    super.initState();
    fetchImageFavoriteAll();
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          ImageList(images, true, (String s) => fetchImageFavoriteAll()),
        ],
      ),
    );
  }
}