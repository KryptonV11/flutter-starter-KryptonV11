import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geo_journal/providers/journal_provider.dart';

class EntriesListScreen extends StatefulWidget {
  const EntriesListScreen({super.key});

  @override
  State<EntriesListScreen> createState() => _EntriesListScreenState();
}

class _EntriesListScreenState extends State<EntriesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JournalProvider>().loadEntries();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final p = context.watch<JournalProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<JournalProvider>().loadEntries(),
        child: Builder(
          builder: (_) {
            if (p.isLoading && p.entries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (p.error != null && p.entries.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text('Ошибка: ${p.error}')),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => context.read<JournalProvider>().loadEntries(),
                      child: const Text('Повторить'),
                    ),
                  ),
                ],
              );
            }

            if (p.entries.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Пока нет записей. Нажми + чтобы добавить')),
                ],
              );
            }

            return ListView.separated(
              itemCount: p.entries.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final e = p.entries[i];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text(
                    (e.lat != null && e.lng != null)
                        ? 'Место: ${e.lat!.toStringAsFixed(5)}, ${e.lng!.toStringAsFixed(5)}'
                        : 'Место: не указано',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: e.id,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
