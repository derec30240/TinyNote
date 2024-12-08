import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/notes_controller.dart';
import 'note_detail_page.dart';

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
                    Get.to(() => NoteDetailPage(index: index));
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
                      Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(notesController.notes[index].dateCreated)),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete Note',
                            middleText: 'Confirm to delete this note?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            buttonColor: Theme.of(context).colorScheme.primary,
                            onConfirm: () {
                              notesController.deleteNote(index);
                              Get.back();
                              final noteDeleteSnackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: const Text('Note deleted.'),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(noteDeleteSnackBar);
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
