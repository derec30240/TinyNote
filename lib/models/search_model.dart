import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/notes_controller.dart';
import 'package:tiny_note/pages/note_detail_page.dart';

class DataSearch extends SearchDelegate<String> {
  NotesController get _notesController => Get.find();

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
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final matchingNoteTitles = _notesController.noteTitles
        .where((title) => title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: matchingNoteTitles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchingNoteTitles[index]),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : _notesController.noteTitles
            .where(
                (title) => title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.text_snippet),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
          title: TextButton(
            onPressed: () {
              Get.to(() => NoteDetailPage(
                  index: _notesController.notes.indexWhere((note) =>
                      note.title?.toLowerCase() ==
                      suggestionList[index].toLowerCase())));
            },
            //matched text, ues bold
            child: Text.rich(
              textAlign: TextAlign.left,
              TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    //the text not matched, so the font colot is grey
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
