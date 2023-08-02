import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actor_repository.dart';
import 'package:cinemapedia/domain/datasources/actor_datasource.dart';

class ActorRepositoryImpl extends ActorRepository {

  final ActorDatasource _actorsDatasource;

  ActorRepositoryImpl( this._actorsDatasource );
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return _actorsDatasource.getActorsByMovie( movieId );
  }
}