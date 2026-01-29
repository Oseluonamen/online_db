import 'package:flutter/material.dart';
import 'package:online_db/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPages extends StatefulWidget {
  const NotesPages({super.key}); 

  @override
  State<NotesPages> createState() => _NotesPagesState();
}

class _NotesPagesState extends State<NotesPages> {

  final textcontroller = TextEditingController();

  // create a note
  void createNote(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          // creat button
          MaterialButton(
            onPressed: (){
              context.read<NoteDatabase>().addNote(textcontroller.text);
            }
          )
        ],
      )
    );
  }

  // read notes

  // update a note

  // delete a note


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(),
        child: Icon(Icons.add),
        ),
    );
  }
}