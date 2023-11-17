import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMansonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MoviesMansonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMansonry> createState() => _MoviesMansonryState();
}

class _MoviesMansonryState extends State<MoviesMansonry> {
  final scrollControllerFavorite = ScrollController();

  // Vamos a crear el scrollcontroller de favoritos
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // creamos el controllador
    scrollControllerFavorite.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollControllerFavorite.position.pixels + 200 >=
          scrollControllerFavorite.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        // Vamos a crear el controller para detectar cuando mostrar las nuevas peliculas
        controller: scrollControllerFavorite,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                MovisPosterLink(movie: widget.movies[index])
              ],
            );
          }
          return MovisPosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
