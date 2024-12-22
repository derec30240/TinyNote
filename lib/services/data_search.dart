import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/pages/widgets/note_card.dart';
import 'package:tiny_note/pages/widgets/task_card.dart';

class DataSearch extends SearchDelegate<String> {
  NotesController get _notesController => Get.find();
  TaskController get _taskController => Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildNoteList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildNoteList(context);
  }

  Widget _buildNoteList(BuildContext context) {
    final noteList = query.isEmpty
        ? []
        : _notesController.noteTitles
            .where(
                (title) => title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    final taskList = query.isEmpty
        ? []
        : _taskController.taskTitles
            .where(
                (title) => title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    if (noteList.isEmpty && taskList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            SizedBox(height: 10),
            Text('No Result'),
          ],
        ),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return NoteCard(
                  uuid: _notesController
                      .notes[_notesController.notes.indexWhere((note) =>
                          note.title?.toLowerCase() ==
                          noteList[index].toLowerCase())]
                      .uuid,
                );
              },
              childCount: noteList.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int taskIndex = _taskController.tasks.indexWhere((task) =>
                    task.title?.toLowerCase() == taskList[index].toLowerCase());
                return TaskCard(
                  uuid: _taskController.tasks[taskIndex].uuid,
                );
              },
              childCount: taskList.length,
            ),
          ),
        ),
      ],
    );
  }
}
