import 'package:flutter/material.dart';
import 'package:weather_now/state/app_state.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key, required this.appState});

  final AppState appState;

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить город'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Введите название города',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Например, Москва',
              ),
              onSubmitted: (_) => _addCity(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addCity,
                child: const Text('Добавить'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addCity() {
    final text = _controller.text;
    final trimmed = text.trim();
    final added = widget.appState.addCity(trimmed);
    if (added) {
      Navigator.of(context).pop(trimmed);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите уникальное название города')),
      );
    }
  }
}
