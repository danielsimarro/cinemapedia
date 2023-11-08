import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDataSource {
  // Hace una base de la url en la llamada de esta
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Enviroment.moviDbKey, 'language': 'es'}));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Con esa Url obtenemos de la api las movies
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }
}
