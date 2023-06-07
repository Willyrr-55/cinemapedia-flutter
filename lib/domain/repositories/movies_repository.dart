import '../entities/movie.dart';

// A pesar que el repository y el datasource puedan tener lo mismo, este se encarga de llamar al datasource 
// Porque repository me va a permitir poder cambiar el datasource facilmente
abstract class MovieRepository{
  
  Future<List<Movie>> getNowPlaying({ int page = 0 });

}