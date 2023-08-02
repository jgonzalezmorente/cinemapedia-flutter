import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/move_repository_impl.dart';

final movieRepositoryProvider = Provider( (ref) {
  return MovieRepositoryImpl( MoviedbDatasource() );
});