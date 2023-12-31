import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb_response.dart';
import 'package:dio/dio.dart';
import '../mappers/video_mapper.dart';
import '../models/moviedb_video.dart';

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

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    // Con esa Url obtenemos de la api las movies
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    // Con esa Url obtenemos de la api las movies
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    // Con esa Url obtenemos de la api las movies
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    // Esto es por si la pelicula no exite con el id
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Video>> getVideo(String id) async {
    final response = await dio.get('/movie/$id/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.movieDTtoEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }

  @override
  Future<List<Movie>> getRecommendations(String id) async {
    // Con esa Url obtenemos de la api las movies
    final response = await dio.get('/movie/$id/recommendations');

    final movieDBRecommendations = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBRecommendations.results
        .
        // COmprobamos si la pelicula no tienen poster no se muestre, con el where
        where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDTtoEntity(moviedb))
        .toList();
    return movies;
  }
}
