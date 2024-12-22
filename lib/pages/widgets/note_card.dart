import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/models/note.dart';
import 'package:tiny_note/pages/note_detail_page.dart';

class NoteCard extends StatefulWidget {
  final String uuid;
  const NoteCard({
    super.key,
    required this.uuid,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  final GlobalController globalController = Get.find();
  final NotesController notesController = Get.find();

  @override
  Widget build(BuildContext context) {
    Note note = notesController
        .notes[notesController.notes.indexWhere((n) => n.uuid == widget.uuid)];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        onTap: () {
          Get.to(() => NoteDetailPage(uuid: widget.uuid));
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
            Text(
                '${(globalController.noteSortOrder.value == 'dateCreated' ? note.dateCreated : note.dateLastEdited).toLocal()}'
                    .substring(0, 16)),
          ],
        ),
      ),
    );
  }
}
