import 'package:flutter/material.dart';
import 'package:weather_now/screens/add_city_screen.dart';
import 'package:weather_now/screens/favorites_screen.dart';
import 'package:weather_now/screens/home_screen.dart';
import 'package:weather_now/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherNow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // home: const HomeScreen(),
      // home: const FavoritesScreen(),
      home: const AddCityScreen(),
    );
  }
}
