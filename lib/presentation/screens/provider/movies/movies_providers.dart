import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/screens/provider/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final featchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: featchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

// Cada vez que llamaemos a load incrementamos en 1 la pagina
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currenPage = 0;

  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    currenPage++;

    // Almacenamos las nuevas peliculas de la nueva pagina
    final List<Movie> movies = await fetchMoreMovies(page: currenPage);
    // Almacenamos el estado y las  peliculas
    state = [...state, ...movies];
  }
}
