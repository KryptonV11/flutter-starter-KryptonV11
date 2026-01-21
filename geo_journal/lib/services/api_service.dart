import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/journal_entry.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<JournalEntry>> fetchEntries() async {
    final url = Uri.parse('$baseUrl/posts?_limit=15');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('Ошибка загрузки: ${res.statusCode}');
    }

    final List data = jsonDecode(res.body) as List;
    return data.map((e) => JournalEntry.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<JournalEntry> createEntry(JournalEntry entry) async {
    final url = Uri.parse('$baseUrl/posts');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(entry.toJson()),
    );

    if (res.statusCode != 201) {
      throw Exception('Ошибка сохранения: ${res.statusCode}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    // JSONPlaceholder вернёт id
    return JournalEntry.fromJson(data).copyWithFallback(entry);
  }
}

extension on JournalEntry {
  JournalEntry copyWithFallback(JournalEntry fallback) {
    return JournalEntry(
      id: id == 0 ? fallback.id : id,
      title: title.isEmpty ? fallback.title : title,
      description: description.isEmpty ? fallback.description : description,
      createdAt: fallback.createdAt,
      lat: fallback.lat,
      lng: fallback.lng,
    );
  }
}
