import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/models/note.dart';

class NotesController extends GetxController {
  static NotesController instance = Get.find();
  GlobalController globalController = Get.find();

  List notes = <Note>[].obs;
  List<String> get noteTitles => [for (Note note in notes) note.title];

  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('notes')) {
      List<String> notesStringList = prefs.getStringList('notes')!;
      notes.assignAll(notesStringList
          .map((noteString) => Note.fromJson(json.decode(noteString)))
          .toList());
    }
    sortNotes();
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notesStringList =
        notes.map((note) => json.encode(note.toJson())).toList();
    prefs.setStringList('notes', notesStringList);
    sortNotes();
  }

  void addNote(String title, String content) {
    notes.add(Note(
      title: title,
      content: content,
      dateCreated: DateTime.now(),
      dateLastEdited: DateTime.now(),
    ));
    update();
    _saveNotes();
  }

  void deleteNote(Note note) {
    int index = notes.indexOf(note);
    if (index != -1) {
      notes.removeAt(index);
    }
    update();
    _saveNotes();
  }

  void editNote(int index, String title, String content) {
    Note oldNote = notes[index];
    notes[index] = Note(
        title: title,
        content: content,
        dateCreated: oldNote.dateCreated,
        dateLastEdited: DateTime.now());
    update();
    _saveNotes();
  }

  void sortNotes() {
    String sortOrder = globalController.noteSortOrder.value;
    bool ascending = globalController.noteSortAscending.value;
    notes.sort((a, b) {
      if (sortOrder == 'dateCreated') {
        if (ascending) {
          return a.dateCreated.compareTo(b.dateCreated);
        }
        return b.dateCreated.compareTo(a.dateCreated);
      }
      if (ascending) {
        return a.dateLastEdited.compareTo(b.dateLastEdited);
      }
      return b.dateLastEdited.compareTo(a.dateLastEdited);
    });
  }
}
