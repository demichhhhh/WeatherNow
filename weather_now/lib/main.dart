import 'package:flutter/material.dart';
import 'package:weather_now/data/city_repository.dart';
import 'package:weather_now/data/weather_service.dart';
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
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    final cityRepository = CityRepository();
    final weatherService = WeatherService();
    appState = AppState(
      cityRepository: cityRepository,
      weatherService: weatherService,
    );
    _initFuture = appState.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

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
      },
    );
  }
}
