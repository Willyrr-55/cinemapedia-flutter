import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/provider/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    // ignore: prefer_const_constructors
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: size.width * 0.3,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: (size.width - 40) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(movie.overview)
                ],
              ),
            ),
          ]),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        _ActorsByMovie(
          movieId: movie.id.toString(),
        ),

        // TODO Mostrar actores ListView

        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final Actor actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(actor.character ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis))
                ],
              ),
            );
          }),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final locaStorageRepository = ref.watch(localStorageRepositoryProvider);
  return locaStorageRepository.isMovieFavorite(movieId); //si esta en favoritos
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
        backgroundColor: Colors.black,
        expandedHeight: size.height * 0.7,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {

              ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
              
            },
            icon: isFavoriteFuture.when(
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
              error: (error, stackTrace) => throw UnimplementedError(), 
              data: (isFavorite) => isFavorite 
                ? const Icon(Icons.favorite_rounded, color: Colors.red,)
                : const Icon(Icons.favorite_border)
            )
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
            // titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // title: Text(
            //   movie.title,
            //   style: const TextStyle(fontSize: 20),
            //   textAlign: TextAlign.start,
            // ),
            background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();

                return FadeIn(child: child);
              },
            ),
          ),

          const _CustomGradient(
            stops: [0.0, 0.2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.black54, Colors.transparent]
          ),

          const _CustomGradient(
            stops: [0.8, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black54],
          ),

          const _CustomGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 0.3],
            colors: [Colors.black87, Colors.transparent],
          )
        ])));
  }
}

class _CustomGradient extends StatelessWidget {
  final List<double> stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry? end;
  final List<Color> colors;

  const _CustomGradient(
      {required this.stops,
      required this.begin,
      required this.colors,
      this.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
      stops: stops,
      begin: begin,
      end: end ?? Alignment.centerRight,
      colors: colors,
    ))));
  }
}
