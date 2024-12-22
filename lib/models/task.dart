class Task {
  String uuid;
  String title;
  String content;
  bool isCompleted;
  DateTime dueDate;

  Task({
    required this.uuid,
    required this.title,
    required this.content,
    this.isCompleted = false,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        uuid: json['uuid'],
        title: json['title'],
        content: json['content'],
        isCompleted: json['isCompleted'],
        dueDate: DateTime.parse(json['dueDate']),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'content': content,
        'isCompleted': isCompleted,
        'dueDate': dueDate.toIso8601String(),
      };
}
