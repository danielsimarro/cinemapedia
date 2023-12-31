import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDTtoEntity(MovieMovieDb moviedb) => Movie(
      adult: moviedb.adult,
      // Es el poster de la movie, colocamos la direccion de la pelicula
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
      releaseDate:
          moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      // Aqui hemos redondeado el valor que nos ofrecen
      voteAverage: double.parse(moviedb.voteAverage.toStringAsFixed(2)),
      voteCount: moviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      // Es el poster de la movie, colocamos la direccion de la pelicula
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
      genreIds: moviedb.genres.map((e) => e.name).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      // Aqui hemos redondeado el valor que nos ofrecen
      voteAverage: double.parse(moviedb.voteAverage.toStringAsFixed(2)),
      voteCount: moviedb.voteCount);
}
