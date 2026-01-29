import 'package:flutter/material.dart';
import 'package:online_db/models/note_database.dart';
import 'package:online_db/models/notes.dart';
import 'package:provider/provider.dart';

class NotesPages extends StatefulWidget {
  const NotesPages({super.key}); 

  @override
  State<NotesPages> createState() => _NotesPagesState();
}

class _NotesPagesState extends State<NotesPages> {

  final textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // on app startup, fetch existing notes
    readNotes();
  }

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
              // add to db
              context.read<NoteDatabase>().addNote(textcontroller.text);
              // pop dialog box
              Navigator.pop(context);
              // clear textfield
              textcontroller.clear();
            },
            child: const Text("Create"),
          )
        ],
      )
    );
  }

  // read notes
  void readNotes(){
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void updateNote (Notes note){
    // pre fill the current 
    textcontroller.text = note.text;
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          // update button
          MaterialButton(
            onPressed: (){
              // update note in db
              context
                .read<NoteDatabase>()
                .updateNote(note.id, textcontroller.text);
              // clear controller
              textcontroller.clear();
              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      )
    );
  }

  // delete a note
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }


  @override
  Widget build(BuildContext context) {

    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Notes> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(),
        child: Icon(Icons.add),
        ),

      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          // get individual note
          final note = currentNotes[index];

          // list tile UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              children: [
                // edit button
                IconButton(
                  onPressed: () => updateNote(note), 
                  icon: const Icon(Icons.edit)
                ),

                // delete button
                IconButton(
                  onPressed: ()=> deleteNote(note.id), 
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          );
        }
        ) ,
    );
  }
}