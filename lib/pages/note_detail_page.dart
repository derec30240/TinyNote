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
  final String uuid;

  NoteDetailPage({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    final Note? currentNote =
        notesController.notes.firstWhereOrNull((n) => n.uuid == uuid);

    if (currentNote == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Center(child: Text('Note not found')),
      );
    }

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
                  currentNote.title,
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
                      ? 'Created on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(currentNote.dateCreated)}'
                      : 'Last edited on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(currentNote.dateLastEdited)}',
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
                      currentNote.content,
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
          Get.off(() => NoteEditPage(
                type: 'edit',
                uuid: currentNote.uuid,
                title: currentNote.title,
                content: currentNote.content,
              ));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
