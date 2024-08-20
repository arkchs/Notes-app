import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/note_tile.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  void addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add a Note',
          style: GoogleFonts.dmSerifText(
              fontSize: 20.0,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          TextButton(
              onPressed: () => {
                    context.read<NoteDatabase>().addNote(_controller.text),
                    _controller.clear(),
                    Navigator.pop(context)
                  },
              child: Text(
                "add",
                style: GoogleFonts.dmSerifText(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.inversePrimary),
              )),
        ],
      ),
    );
  }

  void readNote() {
    context.read<NoteDatabase>().readNotes();
  }

  void updateNote(Note note) {
    _controller.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update a Note',
          style: GoogleFonts.dmSerifText(
              fontSize: 20.0,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          TextButton(
              onPressed: () => {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, _controller.text),
                    _controller.clear(),
                    Navigator.pop(context)
                  },
              child: Text(
                "update",
                style: GoogleFonts.dmSerifText(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.inversePrimary),
              )),
        ],
      ),
    );
  }

  void deleteNote(Note note) {
    context.read<NoteDatabase>().deleteNote(note.id);
  }

  @override
  void initState() {
    super.initState();
    readNote();
  }

  @override
  Widget build(BuildContext context) {
    final notesDatabase = context.watch<NoteDatabase>();
    List<Note> notes = notesDatabase.currentNotes;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteTile(
                    text: notes[index].text,
                    onEditTap: () => updateNote(note),
                    onDeleteTap: () =>
                        {deleteNote(note), Navigator.pop(context)});
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: addNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
