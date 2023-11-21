import 'package:cinemapedia/presentation/screens/provider/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/views/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//init

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  FovoritesViewState createState() => FovoritesViewState();
}

class FovoritesViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final popularMovies = ref.watch(popularMoviesProvider);

    // Si no hay peliculas favoritas
    if (popularMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
          Text(
            'Ohhh no!!',
            style: TextStyle(fontSize: 30, color: colors.primary),
          ),
          const Text(
            'No tienes películas favoritas',
            style: TextStyle(fontSize: 20, color: Colors.black45),
          )
        ],
      ));
    }

    return Scaffold(
        body: MoviesMansonry(
      loadNextPage: loadNextPage,
      movies: popularMovies,
      column: 2,
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
