import 'package:flutter/material.dart';
import 'package:notes_app/constants/theme_provider.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteDatabase()),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes-App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
