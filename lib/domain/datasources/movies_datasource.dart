
// Esta clase es abstracta porque no quiero crear instancias de ella
import '../entities/movie.dart';

abstract class MoviesDatasource{
  
  Future<List<Movie>> getNowPlaying({ int page = 1 });
  
  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getUpcomning({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<Movie> getMovieById( String id );

  Future<List<Movie>> searchMovies(String query);
  // Simplemente defino como lo necesito, no voy a implementar el metodo ni defino mi origenes de datos

}