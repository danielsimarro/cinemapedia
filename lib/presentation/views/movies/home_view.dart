import 'package:cinemapedia/presentation/screens/provider/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topratedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var now = DateTime.now();
    var formatter = DateFormat('EEEE');
    String formattedDate = formatter.format(now);

    // Pantalla de carga
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    // Esto sirve para llamar a la funcion del provider y que nos devuelva la lista de peliculas
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topratedMovies = ref.watch(topratedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: CustomAppbar(),
            )),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            // Custombar
            //const CustomAppbar(),
            // Slide Show principal
            MoviesSlidesshow(movies: slideShowMovies),
            // slide show en cines
            MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: diaSemana(formattedDate),
                loadNextPage: () =>
                    // Llamamos al load
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

            MovieHorizontalListview(
                movies: popularMovies,
                title: 'Popular',
                subTitle: 'En este mes',
                loadNextPage: () =>
                    // Llamamos al load
                    ref.read(popularMoviesProvider.notifier).loadNextPage()),

            MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Proximamente',
                // subTitle: 'Miercoles 08',
                loadNextPage: () =>
                    // Llamamos al load
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage()),

            MovieHorizontalListview(
                movies: topratedMovies,
                title: 'Mejores',
                subTitle: 'Desde siempre',
                loadNextPage: () =>
                    // Llamamos al load
                    ref.read(topratedMoviesProvider.notifier).loadNextPage()),

            const SizedBox(
              height: 10,
            )
          ]);
        }, childCount: 1))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

String diaSemana(day) {
  switch (day.toLowerCase()) {
    case 'monday':
      return 'lunes';
    case 'tuesday':
      return 'martes';
    case 'wednesday':
      return 'miércoles';
    case 'thursday':
      return 'jueves';
    case 'friday':
      return 'viernes';
    case 'saturday':
      return 'sábado';
    case 'sunday':
      return 'domingo';
    default:
      return 'Día no válido';
  }
}
