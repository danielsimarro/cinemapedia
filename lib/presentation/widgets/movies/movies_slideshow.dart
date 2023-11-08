import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlidesshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlidesshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      // Toma todo el ancho posible
      width: double.infinity,

      child: Swiper(
        viewportFraction: 0.8,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0.8),
            builder: DotSwiperPaginationBuilder(
              activeColor: color.primary, // Color de los puntos activos
              color: color.secondary, // Color de los puntos inactivos
            )),
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            // El child hace referencia a la imagen que ya se cargo
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black45));
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
