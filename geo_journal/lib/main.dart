import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/journal_provider.dart';
import 'providers/theme_provider.dart';
import 'services/api_service.dart';

import 'screens/entries_list_screen.dart';
import 'screens/entry_detail_screen.dart';
import 'screens/add_entry_screen.dart';
import 'screens/settings_screen.dart';

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
        '/': (_) => EntriesListScreen(),
        '/detail': (_) => EntryDetailScreen(),
        '/add': (_) => AddEntryScreen(),
        '/settings': (_) => SettingsScreen(),
      },
    );
  }
}
