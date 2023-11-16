import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(
            pageIndex: int.parse(pageIndex),
          );
        }),
    GoRoute(
      // Vamos a mandar el argumento
      path: '/movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieID = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(movieId: movieID);
      },
    ),
    //Esto es para redireccionar al home
    GoRoute(path: '/', redirect: (_, __) => '/home/0')
  ],
);
