import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherNow'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_outline),
            tooltip: 'Избранные',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _CityHeader(
            city: 'Москва',
            description: 'Ясно',
            temperature: '+18°',
            icon: Icons.wb_sunny_rounded,
          ),
          const SizedBox(height: 12),
          _WeatherHighlights(
            feelsLike: '+17°',
            wind: '3 м/с',
            humidity: '42%',
            pressure: '753 мм',
          ),
          const SizedBox(height: 12),
          _ActionButtons(
            onRefresh: () {},
            onFavorites: () {},
          ),
        ],
      ),
    );
  }
}

class _CityHeader extends StatelessWidget {
  const _CityHeader({
    required this.city,
    required this.description,
    required this.temperature,
    required this.icon,
  });

  final String city;
  final String description;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 52, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(city,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Text(
              temperature,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherHighlights extends StatelessWidget {
  const _WeatherHighlights({
    required this.feelsLike,
    required this.wind,
    required this.humidity,
    required this.pressure,
  });

  final String feelsLike;
  final String wind;
  final String humidity;
  final String pressure;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Сейчас',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(
              children: [
                _MetricChip(label: 'Ощущается', value: feelsLike),
                _MetricChip(label: 'Ветер', value: wind),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _MetricChip(label: 'Влажность', value: humidity),
                _MetricChip(label: 'Давление', value: pressure),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onRefresh,
    required this.onFavorites,
  });

  final VoidCallback onRefresh;
  final VoidCallback onFavorites;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Обновить'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onFavorites,
            icon: const Icon(Icons.star_border),
            label: const Text('Избранные'),
          ),
        ),
      ],
    );
  }
}

