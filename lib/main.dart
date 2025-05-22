// /lib
// ├── main.dart
// ├── models/
// │   └── article.dart
// ├── screens/
// │   ├── home_screen.dart
// │   ├── category_screen.dart
// │   ├── bookmarks_screen.dart
// │   ├── settings_screen.dart
// ├── widgets/
// │   └── article_card.dart
// ├── data/
// │   └── dummy_data.dart
// ├── providers/
// │   └── articles_provider.dart

import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/screens/bookmarks_screen.dart';
import 'package:news_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
//Change pubspec.yaml
import 'package:provider/provider.dart';
import 'providers/darkmode_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DarkmodeProvider(),
        
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        
        ),
      ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return Consumer<DarkmodeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'News App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (_) => const HomeScreen(),
            SettingsScreen.routeName: (_) => const SettingsScreen(),
            BookmarksScreen.routeName: (_) => const BookmarksScreen(),
          },
        );
      },
    );
  }
}
