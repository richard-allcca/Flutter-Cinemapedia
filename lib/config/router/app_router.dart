
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: MoviesHomeScreen.name,
      builder: (context, state) => const MoviesHomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id', // Remember quit first slash
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          }
        ),

      ]
    ),
    // GoRoute(
    //   path: '/movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'no-id';

    //     return MovieScreen(movieId: movieId);
    //   }
    // ),
  ]
);