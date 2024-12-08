class Note {
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateLastEdited;

  Note({
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.dateLastEdited,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        content: json['content'],
        dateCreated: DateTime.parse(json['dateCreated']),
        dateLastEdited: DateTime.parse(json['dateLastEdited']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'dateCreated': dateCreated.toIso8601String(),
        'dateLastEdited': dateLastEdited.toIso8601String(),
      };
}
