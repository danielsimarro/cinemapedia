import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  // Buscador de películas
  Future<List<Movie>> searchMovies(String query);

  // Video
  Future<List<Video>> getVideo(String id);

  // Obtener las peliculas recomendadas de otras peliculas
  Future<List<Movie>> getRecommendations(String id);
}
