
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';


final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String,List<Actor>>>((ref) {
  final actorRepository = ref.watch( actorRepositoryProvider ).getActorsByMovie;
  return ActorsByMovieNotifier(getActors: actorRepository);
});

/* 
{ 
  '50543':<Actor>[],
  '50544':<Actor>[],
  '50545':<Actor>[],
  '50546':<Actor>[],
}
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier <Map<String, List<Actor>>>{

  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}):super({});

  Future<void> loadActors(String movieId) async{
    
    if(state[movieId] != null) return;

    final actors = await getActors(movieId);

    state = {...state, movieId:actors };
  }
}