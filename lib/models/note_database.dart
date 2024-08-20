import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];

  Future<void> addNote(String text) async {
    final newNote = Note()..text = text;
    await isar.writeTxn(() => isar.notes.put(newNote));
    readNotes();
  }

  Future<void> readNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNote(Id id, String text) async {
    final originalNote = await isar.notes.get(id);
    if (originalNote != null) {
      originalNote.text = text;
      await isar.writeTxn(() => isar.notes.put(originalNote));
      await readNotes();
    }
  }

  Future<void> deleteNote(Id id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNotes();
  }
}
