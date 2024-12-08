import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notes_controller.dart';

class NoteEditPage extends StatelessWidget {
  final NotesController notesController = Get.find();
  final String type;
  final String title;
  final String content;

  NoteEditPage({
    super.key,
    required this.type,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = (type != 'add')
        ? TextEditingController(text: title)
        : TextEditingController();
    final TextEditingController contentController = (type != 'add')
        ? TextEditingController(text: content)
        : TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('New Note'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: contentController,
                  style: const TextStyle(height: 1.5),
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (type == 'add') {
                    notesController.addNote(
                      titleController.text,
                      contentController.text,
                    );
                    Get.back();
                    // Get.snackbar('Message', 'Note added.');
                    final noteAddSnackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Note added.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(noteAddSnackBar);
                  } else {
                    notesController.editNote(
                      notesController.notes
                          .indexWhere((element) => element.title == title),
                      titleController.text,
                      contentController.text,
                    );
                    Get.back();
                    final noteEditSnackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Note edited.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(noteEditSnackBar);
                  }
                },
                child: (type == 'add')
                    ? const Text('Add Note')
                    : const Text('Confirm Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
