import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/models/note.dart';
import 'package:tiny_note/pages/note_edit_page.dart';

class NoteDetailPage extends StatelessWidget {
  final GlobalController globalController = Get.find();
  final NotesController notesController = Get.find();
  final Note note;

  NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Text(
                  globalController.noteSortOrder.value == 'dateCreated'
                      ? 'Created on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(note.dateCreated)}'
                      : 'Last edited on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(note.dateLastEdited)}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Text(
                      note.content,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteEditPage(
              type: 'edit', title: note.title, content: note.content));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
