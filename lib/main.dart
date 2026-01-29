import 'package:flutter/material.dart';
import 'package:online_db/models/note_database.dart';
import 'package:online_db/pages/notes_pages.dart';
import 'package:provider/provider.dart';

void main() async {
  // intialized note database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPages(),
    );
  }
}