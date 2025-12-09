import 'package:flutter/material.dart';
import 'package:weather_now/screens/home_screen.dart';
import 'package:weather_now/state/app_state.dart';
import 'package:weather_now/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AppState appState;

  @override
  void initState() {
    super.initState();
    appState = AppState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'WeatherNow',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: HomeScreen(appState: appState),
        );
      },
    );
  }
}
