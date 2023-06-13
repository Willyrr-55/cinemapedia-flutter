import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya mero...',
      'Esto esta tardando más de lo esperado 😔'
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FadeIn(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          const Text('Espere porfavor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          // ignore: prefer_const_constructors
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot){
              if( !snapshot.hasData )return const Text('Cargando');
        
              return Text(snapshot.data!);
            }
          )
              ],
            ),
        ));
  }
}
