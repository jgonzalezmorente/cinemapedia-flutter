import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movidedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity( Cast cast ) => 
    Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null 
        ? 'https://image.tmdb.org/t/p/w500/${ cast.profilePath }'
        : 'https://upload.wikimedia.org/wikipedia/commons/2/2f/No-photo-m.png',
      character: cast.character
    );



}