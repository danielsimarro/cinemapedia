import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';

// Esto basicamente llama al data source y del data source llama a los metodos
class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;

  MovieRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
