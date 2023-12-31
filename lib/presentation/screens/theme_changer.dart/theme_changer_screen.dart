import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/theme_provider.dart';


class ThemeChangerScreen extends ConsumerWidget {

  static const String name = 'theme_changer_screen';
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isDarkMoode = ref.watch( themeNotifierProvider ).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            // icon: Icon(Icons.light_mode_outlined),
            icon: Icon( isDarkMoode? Icons.dark_mode_outlined:Icons.light_mode_outlined),
            onPressed: (){
              // ref.read(isDarkModeProvider.notifier).update((state) => !state);
              ref.read( themeNotifierProvider.notifier).toggleDarkMode();
            }, 
          )
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef  ref) {

    final listColors = ref.watch( colorListProvider );
    // final int selectedColor = ref.watch( selectedColorProvider );
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
      itemCount: listColors.length, 
      itemBuilder: (BuildContext context, int index) {

        final Color color = listColors[index];

        return RadioListTile.adaptive(
          title: Text('Este color', style: TextStyle( color: color),),
          subtitle: Text('${color.value}'),
          activeColor: color,
          value:index,
          groupValue: selectedColor,
          onChanged: (value){
            // ref.read(selectedColorProvider.notifier).update((state) => value!);
            ref.read(themeNotifierProvider.notifier).changeColorIndex(value!);
          },
        );
      },
    );
  }
}