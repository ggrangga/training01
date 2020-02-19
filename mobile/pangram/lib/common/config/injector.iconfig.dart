// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:demo_app/common/network/ws_client.dart';
import 'package:http/src/client.dart';
import 'package:demo_app/data/favorite_movie/datasources/favorite_remote_datasource.dart';
import 'package:demo_app/data/omdb_movie/datasources/omdb_remote_datasource.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<MovieClient>(() => MovieClientImpl(getIt<Client>()))
    ..registerLazySingleton<MovieClientImpl>(
        () => MovieClientImpl(getIt<Client>()))
    ..registerFactory<FavoriteMovieRemoteDatasource>(
        () => FavoriteMovieRemoteDatasourceImpl(client: getIt<MovieClient>()))
    ..registerLazySingleton<FavoriteMovieRemoteDatasourceImpl>(
        () => FavoriteMovieRemoteDatasourceImpl(client: getIt<MovieClient>()))
    ..registerFactory<OmdbRemoteDatasource>(
        () => OmdbRemoteDatasourceImpl(client: getIt<MovieClient>()))
    ..registerLazySingleton<OmdbRemoteDatasourceImpl>(
        () => OmdbRemoteDatasourceImpl(client: getIt<MovieClient>()));
}
