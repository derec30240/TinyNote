import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/models/note.dart';
import 'package:tiny_note/pages/note_detail_page.dart';

class NotesPage extends StatelessWidget {
  final GlobalController globalController = Get.find();
  final NotesController notesController = Get.find();

  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => (notesController.notes.isEmpty)
        ? const Center(
            child: Text(
              'No notes yet.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: notesController.notes.length,
              itemBuilder: (context, index) {
                //FIXME: If the `notesSortOrder` is `dateLastEdited`, when finished edit, it may go back to another NoteDetailPage. Try not to use `index` to index the note, or maybe other solutions.
                Note note = notesController.notes[index];
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        autoClose: true,
                        onPressed: (content) {
                          Get.defaultDialog(
                            title: 'Delete Note',
                            middleText: 'Confirm to delete this note?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
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
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: noteCard(context, note, index),
                );
              },
            ),
          ));
  }

  Widget noteCard(BuildContext context, Note note, int index) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.to(() => NoteDetailPage(index: index));
        },
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const Divider(),
            Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(
                globalController.noteSortOrder.value == 'dateCreated'
                    ? note.dateCreated
                    : note.dateLastEdited)),
          ],
        ),
      ),
    );
  }
}
