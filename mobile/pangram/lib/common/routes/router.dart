import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:demo_app/presentation/pages/home/home/home_page.dart';
import 'package:demo_app/presentation/pages/login/login_screen.dart';
import 'package:demo_app/presentation/pages/home/search/search_screen.dart';
import 'package:demo_app/presentation/pages/home/favorite/favorite_screen.dart';
import 'package:demo_app/presentation/pages/home/setting/setting_screen.dart';
import 'package:demo_app/presentation/pages/home/search/movieDetail_screen.dart';
import 'package:demo_app/presentation/pages/home/pangram/showPangram_screen.dart';

abstract class Router {
  static Map<String, WidgetBuilder> routes = {
    Routes.home: (BuildContext context) => HomePage(),
    Routes.dashboard: (BuildContext context) => HomePage(page: HomePageOptions.dashboard,),
    Routes.login: (BuildContext context) => LoginScreen(),
    Routes.search: (BuildContext context) => SearchScreen(),
    Routes.favoriteList: (BuildContext context) => FavoriteScreen(),  
    Routes.settings: (BuildContext context) => SettingScreen(),
    Routes.movieDetail: (BuildContext context) => MovieDetailScreen(),  
    Routes.pangram: (BuildContext context) => PangramScreen(),  
  };
}