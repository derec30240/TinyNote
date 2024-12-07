import 'dart:convert';

import 'package:flutter/material.dart';

class Note {
  int id;
  String title;
  String content;
  Color color;
  DateTime dateCreated;
  DateTime dateLastEdited;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.dateCreated,
    required this.dateLastEdited,
  });

  @override
  String toString() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color.toString(),
      'dateCreated': epochFromDate(dateCreated),
      'dateLastEdited': epochFromDate(dateLastEdited),
    }.toString();
  }

  Map<String, dynamic> toMap(bool isforUpdate) {
    var data = {
      // Since id is auto incermented in the database we don't need to send it to the insert query.
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'color': color.value,
      'dateCreated': epochFromDate(dateCreated),
      'dateLastEdited': epochFromDate(dateLastEdited),
    };
    if (isforUpdate) {
      data['id'] = id;
    }
    return data;
  }

  /// Converting the date time object into int representing seconds passed
  /// after midnight 1st Jan, 1970 UTC
  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }
}
