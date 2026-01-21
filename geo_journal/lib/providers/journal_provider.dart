import 'package:flutter/foundation.dart';
import '../models/journal_entry.dart';
import '../services/api_service.dart';

class JournalProvider extends ChangeNotifier {
  final ApiService api;

  JournalProvider(this.api);

  List<JournalEntry> entries = [];
  bool isLoading = false;
  String? error;

  Future<void> loadEntries() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      entries = await api.fetchEntries();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addEntry(JournalEntry entry) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final created = await api.createEntry(entry);
      // Добавим в начало списка, чтобы пользователь увидел результат сразу
      entries = [created, ...entries];
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  JournalEntry? findById(int id) {
    try {
      return entries.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
