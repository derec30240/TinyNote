import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notes_controller.dart';

class NotesPage extends StatelessWidget {
  final NotesController notesController = Get.find();

  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => (notesController.notes.isEmpty)
        ? Container(
            child: const Center(
              child: Text(
                'No notes yet.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: notesController.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    //TODO: Move to the note_detail_page
                  },
                  title: Text(
                    notesController.notes[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    notesController.notes[index].content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(notesController.notes[index].dateLastEdited),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete Note',
                            middleText: 'Confirm to delete this note?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            onConfirm: () {
                              notesController.deleteNote(index);
                              Get.back();
                              Get.snackbar(
                                'Message',
                                'Note deleted',
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            ),
          ));
  }
}
