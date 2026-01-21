import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geo_journal/models/journal_entry.dart';
import 'package:geo_journal/providers/journal_provider.dart';
import 'package:geo_journal/services/location_service.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  double? lat;
  double? lng;

  bool gettingLocation = false;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    setState(() => gettingLocation = true);
    try {
      final pos = await LocationService().getCurrentPosition();
      setState(() {
        lat = pos.latitude;
        lng = pos.longitude;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Локация получена')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (!mounted) {
        setState(() => gettingLocation = false);
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final entry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch, // локальный id
      title: _title.text.trim(),
      description: _desc.text.trim(),
      createdAt: DateTime.now(),
      lat: lat,
      lng: lng,
    );

    try {
      await context.read<JournalProvider>().addEntry(entry);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Запись сохранена (POST)')),
        );
        Navigator.pop(context);
      }
    } catch (_) {
      // ошибка уже есть в provider + snackbar можно показать при желании
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<JournalProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить запись')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Заголовок'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Введите заголовок' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Описание'),
                minLines: 3,
                maxLines: 6,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Введите описание' : null,
              ),
              const SizedBox(height: 16),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Локация'),
                subtitle: Text(
                  lat != null ? '${lat!.toStringAsFixed(5)}, ${lng!.toStringAsFixed(5)}' : 'Не получена',
                ),
                trailing: ElevatedButton(
                  onPressed: gettingLocation ? null : _getLocation,
                  child: gettingLocation
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Получить GPS'),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: (isLoading) ? null : _save,
                icon: const Icon(Icons.save),
                label: Text(isLoading ? 'Сохранение...' : 'Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
