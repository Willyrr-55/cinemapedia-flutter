import 'package:flutter/material.dart';

const colorsList = <Color>[
  Colors.blue,
  Colors.red,
  Colors.teal,
  Colors.green,
  Colors.deepPurple,
  Colors.yellow,
  Colors.black
];

class AppTheme{

  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = true,
    this.selectedColor = 0,
  })
    :assert(selectedColor >= 0 && selectedColor <= colorsList.length-1, 'Selected color must be greater than or equal to 0 and less than ${colorsList.length}');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkMode? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorsList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: false
    ),
  );

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode
  }) => AppTheme(
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkMode: isDarkMode ?? this.isDarkMode
  );
}