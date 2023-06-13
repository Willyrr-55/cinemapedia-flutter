

import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasource{

  Future <List<Actor>> getActorsByMovie ( String movieId );
  // De esta manera no se hace la implementacion del metodo solo se define

}