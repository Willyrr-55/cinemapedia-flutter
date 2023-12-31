


import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final searchQueryProvider = StateProvider <String>((ref) => ''); 

final searchMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

  final movieRepository = ref.watch( movieRepositoryProvider );
  return SearchedMoviesNotifier(
    ref: ref,
    searchMovies: movieRepository.searchMovies
  );
});

typedef SearchedMoviesCallback = Future <List<Movie>> Function (String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>>{

  final SearchedMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier ({
    required this.searchMovies,
    required this.ref,
  }): super([]);

  Future <List<Movie>> searchMoviesByQuery ( String query ) async{

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;

    return movies;
  }
  
}