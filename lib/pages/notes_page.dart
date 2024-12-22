import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/pages/widgets/note_card.dart';

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
                String uuid = notesController.notes[index].uuid;
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
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
                              notesController.deleteNote(uuid);
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
                  child: NoteCard(uuid: uuid),
                ).animate().fade().slide(duration: Duration(milliseconds: 300));
              },
            ),
          ));
  }
}
