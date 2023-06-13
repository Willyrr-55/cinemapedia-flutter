import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/representation/provider/providers.dart';
import 'package:go_router/go_router.dart';
import '../../delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {

  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(  Icons.movie_outlined, color: colors.primary ),
              const SizedBox(width: 5),
              Text('Sinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: (){

                  // TODO: 
                  final searchedMovies = ref.read( searchMoviesProvider );
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      // Mando la referencia a la funcion en searchMovies
                      searchMovies:ref.read( searchMoviesProvider.notifier ).searchMoviesByQuery,
                      initialMovies: searchedMovies
                    ) 
                  ).then((movie) {
                    if(movie == null)return;
                    context.push('/movie/${movie.id}');
                  });
                }, 
                icon: const Icon(Icons.search)
              )
            ]
          ),
        ),
      ),
    );
  }
}