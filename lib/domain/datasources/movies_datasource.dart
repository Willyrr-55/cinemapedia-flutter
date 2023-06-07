
// Esta clase es abstracta porque no quiero crear instancias de ella
import '../entities/movie.dart';

abstract class MovieDatasource{
  
  Future<List<Movie>> getNowPlaying({ int page = 0 });
  // Simplemente defino como lo necesito, no voy a implementar el metodo ni defino mi origenes de datos

}