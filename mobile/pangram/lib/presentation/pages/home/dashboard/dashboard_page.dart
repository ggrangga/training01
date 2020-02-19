
import 'package:flutter/material.dart';
import 'package:demo_app/presentation/widget/imageDetail_list.dart';
import 'package:demo_app/domain/favorite/entities/imageDetail_model.dart';
import 'package:demo_app/common/config/injector.dart';
import 'package:demo_app/data/favorite_movie/datasources/favorite_remote_datasource.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}
class AppState extends State<DashboardPage> {
  List<ImageDetailModel> images = [];
  final FavoriteMovieRemoteDatasource omdbRDS = getIt<FavoriteMovieRemoteDatasource>();

  void fetchImage() async {
    List<ImageDetailModel> thisImages = await omdbRDS.fetchImageForRecomended();
    if (mounted && thisImages.length > 0) {
      setState(() {
        images = thisImages;
      });
    }
  }

  void initState() {
    super.initState();

    fetchImage();
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          ImageList(images, false, (String s) => s),
        ],
      ),
    );
  }
}