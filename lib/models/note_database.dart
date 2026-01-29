import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:online_db/models/notes.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // initialize data base
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
    [NotesSchema], 
    directory: dir.path
    );
  }

  // list of notes
  final List<Notes> currentNotes = [];

  // create - a note and save to db
  Future<void> addNote(String textFromUser) async{
    // creat a new note object
    final newNote = Notes()..text = textFromUser;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from db
    fetchNotes();
  }
  // read - notes from db
  Future<void> fetchNotes() async {
    List<Notes> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();

  }

  // update - a note in db
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes(); 
    }
  
  }

  // delete - a note from the db
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}