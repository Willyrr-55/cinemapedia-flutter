import 'package:cinemapedia/representation/screens/screens.dart';
import 'package:cinemapedia/representation/screens/theme_changer.dart/theme_changer_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0', 
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? 0;
          return HomeScreen(pageIndex: int.parse(pageIndex.toString()));
        },
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
      path: '/',
      redirect: ( _ , __ ) => '/home/0'
    ),

    GoRoute(
        path: '/theme-changer',
        name:ThemeChangerScreen.name,
        builder: (context, state) => const ThemeChangerScreen()
    ),
  ]
);
