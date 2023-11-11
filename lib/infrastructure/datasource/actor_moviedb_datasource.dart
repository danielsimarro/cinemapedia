import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Enviroment.moviDbKey, 'language': 'es'}));
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castDBResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = castDBResponse.cast
        .map((moviedb) => ActorMapper.castToEntitiy(moviedb))
        .toList();

    return actors;
  }
}
