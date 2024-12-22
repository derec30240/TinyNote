import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/models/task.dart';
import 'package:tiny_note/pages/task_edit_page.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';

class TaskCard extends StatefulWidget {
  final String uuid;
  const TaskCard({
    super.key,
    required this.uuid,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    Task task = taskController
        .tasks[taskController.tasks.indexWhere((t) => t.uuid == widget.uuid)];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        onTap: () {
          Get.to(() => TaskEditPage(uuid: widget.uuid));
        },
        leading: IconButton(
          onPressed: () {
            taskController.toggleTaskCompletion(widget.uuid);
            setState(() {});
          },
          icon: Icon(
              task.isCompleted ? Icons.task_alt : Icons.circle_outlined),
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.content,
              style: TextStyle(
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  '${task.dueDate.toLocal()}'.substring(0, 16),
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.alarm),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
