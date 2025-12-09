import 'package:shared_preferences/shared_preferences.dart';

class CityState {
  CityState({required this.cities, required this.selectedIndex});

  final List<String> cities;
  final int selectedIndex;
}

class CityRepository {
  static const _citiesKey = 'cities';
  static const _selectedIndexKey = 'selected_index';

  Future<CityState> load() async {
    final prefs = await SharedPreferences.getInstance();
    final cities = prefs.getStringList(_citiesKey) ?? <String>[];
    final selectedIndex = prefs.getInt(_selectedIndexKey) ?? 0;
    return CityState(cities: cities, selectedIndex: selectedIndex);
  }

  Future<void> save(List<String> cities, int selectedIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_citiesKey, cities);
    await prefs.setInt(_selectedIndexKey, selectedIndex);
  }
}

