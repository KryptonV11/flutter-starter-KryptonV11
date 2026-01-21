import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geo_journal/providers/journal_provider.dart';
import 'package:geo_journal/providers/theme_provider.dart';
import 'package:geo_journal/services/api_service.dart';

import 'package:geo_journal/screens/entries_list_screen.dart';
import 'package:geo_journal/screens/entry_detail_screen.dart';
import 'package:geo_journal/screens/add_entry_screen.dart';
import 'package:geo_journal/screens/settings_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => JournalProvider(ApiService())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geo Journal',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (_) => const EntriesListScreen(),
        '/detail': (_) => const EntryDetailScreen(),
        '/add': (_) => const AddEntryScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
