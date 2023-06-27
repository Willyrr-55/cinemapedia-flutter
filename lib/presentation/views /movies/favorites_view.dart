import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../provider/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(favoriteMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: favoritesMovies.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(favoritesMovies[index].title),
          );
        }
      )
    );
  }
}