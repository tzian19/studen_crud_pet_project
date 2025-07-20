import 'package:flutter/material.dart';
import 'features/notes/presentation/pages/notes_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 3,
            shape: CircleBorder(),
          ),
      ),
      home: const NotesHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}