import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/models/note.dart';
import 'package:tiny_note/pages/note_detail_page.dart';

Widget noteCard(BuildContext context, Note note, int index,
    {bool isSearch = false}) {
  final GlobalController globalController = Get.find();
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(20),
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
          Text(
              '${(globalController.noteSortOrder.value == 'dateCreated' ? note.dateCreated : note.dateLastEdited).toLocal()}'
                  .substring(0, 16)),
        ],
      ),
    ),
  );
}
