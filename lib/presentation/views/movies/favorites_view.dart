import 'package:cinemapedia/presentation/screens/provider/storage/local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/provider/storage/favorite_movies_provider.dart';

//init

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FovoritesViewState createState() => FovoritesViewState();
}

class FovoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites View'),
        ),
        body: ListView.builder(
            itemCount: favoritesMovies.length,
            itemBuilder: (context, index) {
              final movie = favoritesMovies[index];
              return ListTile(
                title: Text(movie.title),
              );
            }));
  }
}
