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
    // TODO: implement build
    throw UnimplementedError();
  }
}
