import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geo_journal/providers/journal_provider.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final id = (args is int) ? args : null;

    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Детали')),
        body: const Center(child: Text('Не передан id записи')),
      );
    }

    final entry = context.watch<JournalProvider>().findById(id);

    if (entry == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Детали')),
        body: const Center(child: Text('Запись не найдена')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Детали записи')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              entry.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(entry.description),
            const SizedBox(height: 16),
            Text('Дата: ${entry.createdAt.toLocal()}'),
            const SizedBox(height: 12),
            Text(
              entry.lat != null && entry.lng != null
                  ? 'Локация: ${entry.lat!.toStringAsFixed(5)}, ${entry.lng!.toStringAsFixed(5)}'
                  : 'Локация: нет',
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
