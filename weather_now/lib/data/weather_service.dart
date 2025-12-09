import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_now/models/weather.dart';

class WeatherService {
  static const _geocodeBase =
      'https://geocoding-api.open-meteo.com/v1/search';
  static const _forecastBase = 'https://api.open-meteo.com/v1/forecast';

  Future<Weather> fetchCurrentWeather(String city) async {
    final location = await _geocode(city);
    final forecast = await _fetchForecast(location.lat, location.lon);
    return forecast;
  }

  Future<_Location> _geocode(String city) async {
    final uri = Uri.parse(
      '$_geocodeBase?name=${Uri.encodeComponent(city)}&count=1&language=ru',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Ошибка геокодирования (${response.statusCode})');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) {
      throw Exception('Город не найден');
    }
    final first = results.first as Map<String, dynamic>;
    return _Location(
      lat: (first['latitude'] as num).toDouble(),
      lon: (first['longitude'] as num).toDouble(),
      name: first['name'] as String? ?? city,
    );
  }

  Future<Weather> _fetchForecast(double lat, double lon) async {
    final uri = Uri.parse(
      '$_forecastBase?latitude=$lat&longitude=$lon&current_weather=true',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Ошибка прогноза (${response.statusCode})');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final current = data['current_weather'] as Map<String, dynamic>?;
    if (current == null) {
      throw Exception('Нет данных о погоде');
    }
    final temp = (current['temperature'] as num).toDouble();
    final wind = (current['windspeed'] as num).toDouble();
    final code = current['weathercode'] as int? ?? 0;
    return Weather(
      temperature: temp,
      feelsLike: temp,
      wind: wind,
      humidity: null,
      pressure: null,
      description: _mapWeatherCode(code),
    );
  }

  String _mapWeatherCode(int code) {
    if (code == 0) return 'Ясно';
    if (code == 1 || code == 2) return 'Переменная облачность';
    if (code == 3) return 'Пасмурно';
    if (code == 45 || code == 48) return 'Туман';
    if ({51, 53, 55}.contains(code)) return 'Морось';
    if ({61, 63, 65}.contains(code)) return 'Дождь';
    if ({71, 73, 75}.contains(code)) return 'Снег';
    if ({80, 81, 82}.contains(code)) return 'Ливень';
    if ({95, 96, 99}.contains(code)) return 'Гроза';
    return 'Погода';
  }
}

class _Location {
  _Location({required this.lat, required this.lon, required this.name});
  final double lat;
  final double lon;
  final String name;
}

