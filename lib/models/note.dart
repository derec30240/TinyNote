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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note &&
        other.title == title &&
        other.content == content &&
        other.dateCreated == dateCreated &&
        other.dateLastEdited == dateLastEdited;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      content.hashCode ^
      dateCreated.hashCode ^
      dateLastEdited.hashCode;
}
