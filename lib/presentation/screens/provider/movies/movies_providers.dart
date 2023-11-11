import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/screens/provider/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final featchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: featchMoreMovies);
});

// Popular movies provider
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final featchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(fetchMoreMovies: featchMoreMovies);
});

// Upcoming provider
final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final featchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  return MoviesNotifier(fetchMoreMovies: featchMoreMovies);
});

// Top-rated provider
final topratedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final featchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(fetchMoreMovies: featchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

// Cada vez que llamaemos a load incrementamos en 1 la pagina
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currenPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currenPage++;
    // Almacenamos las nuevas peliculas de la nueva pagina
    final List<Movie> movies = await fetchMoreMovies(page: currenPage);
    // Almacenamos el estado y las  peliculas
    state = [...state, ...movies];
    isLoading = false;
  }
}
