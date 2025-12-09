import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleCities = ['Москва', 'Санкт-Петербург', 'Казань'];

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
                itemCount: sampleCities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final city = sampleCities[index];
                  return ListTile(
                    leading: Radio<int>(
                      value: index,
                      groupValue: 0,
                      onChanged: (_) {},
                    ),
                    title: Text(city),
                    trailing: IconButton(
                      onPressed: () {},
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
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Добавить город'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

