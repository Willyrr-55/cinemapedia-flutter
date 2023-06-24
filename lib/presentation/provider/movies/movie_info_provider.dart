
import 'package:cinemapedia/presentation/provider/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String,Movie>>((ref) {
  final movieRepository = ref.watch( movieRepositoryProvider ).getMovieById;
  return MovieMapNotifier(getMovie: movieRepository);
});

/* 
{ 
  '50543':Movie(),
  '50544':Movie(),
  '50545':Movie(),
  '50546':Movie(),
}
*/

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier <Map<String, Movie>>{

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}):super({});

  Future<void> loadMovie(String movieId) async{
    
    if(state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId:movie };
  }
}