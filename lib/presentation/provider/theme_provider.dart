
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/app_theme.dart';



// Listado de colores inmutables
final colorListProvider = Provider((ref) => colorsList);

// A simple bool 
final isDarkModeProvider = StateProvider<bool>((ref) => true);

// A simple int 
final selectedColorProvider = StateProvider<int>((ref) => 0);

// An object of type Apptheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// Se le puede nombrar coontroller o notifier
class ThemeNotifier extends StateNotifier<AppTheme>{

  // State = Estado = new AppTheme();
  ThemeNotifier():super(AppTheme());

  void toggleDarkMode(){
    state = state.copyWith(
      isDarkMode: !state.isDarkMode
    );
  }

  void changeColorIndex( int colorIndex ){
    state = state.copyWith(
      selectedColor: colorIndex
    );
  }
  
}