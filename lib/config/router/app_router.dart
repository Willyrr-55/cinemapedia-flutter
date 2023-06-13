import 'package:cinemapedia/representation/screens/screens.dart';
import 'package:cinemapedia/representation/screens/theme_changer.dart/theme_changer_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, GoRouterState state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(movieId: movieId);
            }),
      ]
  ),
  GoRoute(
      path: '/theme-changer',
      name:ThemeChangerScreen.name,
      builder: (context, state) => const ThemeChangerScreen()
  ),
]);
