import 'package:flutter/material.dart';
import 'package:weather_now/screens/add_city_screen.dart';
import 'package:weather_now/state/app_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Избранные города'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: appState.cities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final city = appState.cities[index];
                      return ListTile(
                        leading: Radio<int>(
                          value: index,
                          groupValue: appState.selectedIndex,
                          onChanged: (value) async {
                            if (value == null) return;
                            await appState.selectCity(value);
                          },
                        ),
                        title: Text(city),
                        trailing: IconButton(
                          onPressed: () => _removeCity(context, index),
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Удалить',
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openAddCity(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить город'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openAddCity(BuildContext context) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => AddCityScreen(appState: appState),
      ),
    );
    if (result != null && result.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Добавлено: $result')),
      );
    }
  }

  Future<void> _removeCity(BuildContext context, int index) async {
    final removed = await appState.removeCity(index);
    if (!removed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нужен хотя бы один город')),
      );
    }
  }
}
