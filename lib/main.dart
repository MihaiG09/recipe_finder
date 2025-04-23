import 'package:flutter/material.dart';
import 'package:recipe_finder/common/theme/theme_builder.dart';
import 'package:recipe_finder/features/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeBuilder.getThemeData(),
      home: const HomeScreen(),
    );
  }
}
