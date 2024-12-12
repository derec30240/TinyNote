class Task {
  String title;
  String content;
  bool isCompleted;
  DateTime dueDate;

  Task({
    required this.title,
    required this.content,
    this.isCompleted = false,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        content: json['content'],
        isCompleted: json['isCompleted'],
        dueDate: DateTime.parse(json['dueDate']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'isCompleted': isCompleted,
        'dueDate': dueDate.toIso8601String(),
      };
}
