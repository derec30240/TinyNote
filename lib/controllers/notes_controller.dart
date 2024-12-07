import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';

class NotesController extends GetxController {
  static NotesController instance = Get.find();
  List notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('notes')) {
      List<String> notesStringList = prefs.getStringList('notes')!;
      notes.assignAll(notesStringList.map((noteString) {
        Map<String, dynamic> noteMap = json.decode(noteString);
        return Note(
            title: noteMap['title'],
            content: noteMap['content'],
            dateCreated: noteMap['dateCreated'],
            dateLastEdited: noteMap['dateLastEdited']);
      }).toList());
    }
  }

  _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesStringList = notes
        .map((note) => json.encode({
              'title': note.title,
              'content': note.content,
              'dateCreated': note.dateCreated,
              'dateLastEdited': note.dateLastEdited
            }))
        .toList();
    prefs.setStringList('notes', notesStringList);
  }

  void addNote(String title, String content) {
    notes.add(Note(
      title: title,
      content: content,
      dateCreated: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      dateLastEdited: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    ));
    update();
    _saveNotes();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    update();
    _saveNotes();
  }

  void editNote(int index, String title, String content) {
    Note oldNote = notes[index];
    notes[index] = Note(
        title: title,
        content: content,
        dateCreated: oldNote.dateCreated,
        dateLastEdited:
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    update();
    _saveNotes();
  }
}
