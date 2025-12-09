import 'package:flutter/material.dart';
import 'package:weather_now/data/city_repository.dart';
import 'package:weather_now/data/weather_service.dart';
import 'package:weather_now/models/weather.dart';

class AppState extends ChangeNotifier {
  AppState({
    required this.cityRepository,
    required this.weatherService,
  });

  final CityRepository cityRepository;
  final WeatherService weatherService;

  List<String> _cities = [];
  int _selectedIndex = 0;
  Weather? _weather;
  bool isLoadingWeather = false;
  String? error;
  bool initialized = false;

  List<String> get cities => List.unmodifiable(_cities);
  int get selectedIndex => _selectedIndex;
  String get selectedCity =>
      _cities.isNotEmpty ? _cities[_selectedIndex.clamp(0, _cities.length - 1)] : '';
  Weather? get weather => _weather;

  Future<void> init() async {
    final stored = await cityRepository.load();
    _cities = stored.cities.isNotEmpty
        ? stored.cities
        : ['Москва', 'Санкт-Петербург', 'Казань'];
    _selectedIndex =
        stored.selectedIndex.clamp(0, _cities.isEmpty ? 0 : _cities.length - 1);
    initialized = true;
    notifyListeners();
    await fetchWeather();
  }

  Future<void> fetchWeather() async {
    if (_cities.isEmpty) return;
    isLoadingWeather = true;
    error = null;
    notifyListeners();
    try {
      _weather = await weatherService.fetchCurrentWeather(selectedCity);
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoadingWeather = false;
      notifyListeners();
    }
  }

  Future<bool> addCity(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final exists = _cities.any((c) => c.toLowerCase() == trimmed.toLowerCase());
    if (exists) return false;
    _cities.add(trimmed);
    _selectedIndex = _cities.length - 1;
    await _persist();
    await fetchWeather();
    return true;
  }

  Future<void> selectCity(int index) async {
    if (index < 0 || index >= _cities.length) return;
    _selectedIndex = index;
    await _persist();
    await fetchWeather();
  }

  Future<bool> removeCity(int index) async {
    if (_cities.length <= 1) return false;
    if (index < 0 || index >= _cities.length) return false;
    _cities.removeAt(index);
    if (_selectedIndex >= _cities.length) {
      _selectedIndex = _cities.length - 1;
    }
    await _persist();
    await fetchWeather();
    return true;
  }

  Future<void> _persist() async {
    await cityRepository.save(_cities, _selectedIndex);
    notifyListeners();
  }
}

