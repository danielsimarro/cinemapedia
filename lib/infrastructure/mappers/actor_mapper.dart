import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/credits_response.dart';

class ActorMapper {
  //Es el nombre del actor
  static Actor castToEntitiy(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
      character: cast.character);
}
