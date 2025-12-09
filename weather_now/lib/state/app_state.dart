import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<String> _cities = ['Москва', 'Санкт-Петербург', 'Казань'];
  int _selectedIndex = 0;

  List<String> get cities => List.unmodifiable(_cities);
  int get selectedIndex => _selectedIndex;
  String get selectedCity =>
      _cities.isNotEmpty ? _cities[_selectedIndex.clamp(0, _cities.length - 1)] : '';

  void selectCity(int index) {
    if (index < 0 || index >= _cities.length) return;
    _selectedIndex = index;
    notifyListeners();
  }

  bool addCity(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final exists = _cities.any((c) => c.toLowerCase() == trimmed.toLowerCase());
    if (exists) return false;
    _cities.add(trimmed);
    _selectedIndex = _cities.length - 1;
    notifyListeners();
    return true;
  }

  bool removeCity(int index) {
    if (_cities.length <= 1) return false;
    if (index < 0 || index >= _cities.length) return false;
    _cities.removeAt(index);
    if (_selectedIndex >= _cities.length) {
      _selectedIndex = _cities.length - 1;
    }
    notifyListeners();
    return true;
  }
}

