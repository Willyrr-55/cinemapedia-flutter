import '../entities/movie.dart';

// A pesar que el repository y el datasource puedan tener lo mismo, este se encarga de llamar al datasource 
// Porque repository me va a permitir poder cambiar el datasource facilmente
abstract class MoviesRepository{
  
  Future<List<Movie>> getNowPlaying({ int page = 1 });
  
  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getUpcomning({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<Movie> getMovieById( String id );

  Future<List<Movie>> searchMovies(String query);

}