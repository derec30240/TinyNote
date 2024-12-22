class Note {
  String uuid;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateLastEdited;

  Note({
    required this.uuid,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.dateLastEdited,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        uuid: json['uuid'],
        title: json['title'],
        content: json['content'],
        dateCreated: DateTime.parse(json['dateCreated']),
        dateLastEdited: DateTime.parse(json['dateLastEdited']),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'content': content,
        'dateCreated': dateCreated.toIso8601String(),
        'dateLastEdited': dateLastEdited.toIso8601String(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
