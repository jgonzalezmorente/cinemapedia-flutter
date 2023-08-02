import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environments.dart';

import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movidedb/credits_response.dart';
import 'package:cinemapedia/domain/datasources/actor_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';


class ActorMovieDbDatasource extends ActorDatasource {

  final dio = Dio( BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Envirionments.theMovieDbKey,
        'language': 'es-ES'
      }
    )
  );

  @override
  Future<List<Actor>> getActorsByMovie( String movieId ) async {
    
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    if ( response.statusCode != 200 ) throw Exception( 'Credit for movie with id: $movieId not found' );

    final creditsResponse = CreditsResponse.fromJson( response.data );    
    final actors = creditsResponse.cast.map( ActorMapper.castToEntity ).toList();
    return actors;
    
  }

}