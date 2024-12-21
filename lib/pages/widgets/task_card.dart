import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/models/task.dart';
import 'package:tiny_note/pages/task_edit_page.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';

Widget taskCard(BuildContext context, Task task, int index) {
  final TaskController taskController = Get.find();
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(20),
      onTap: () {
        Get.to(() => TaskEditPage(
              task: task,
              index: index,
            ));
      },
      leading: IconButton(
        onPressed: () {
          taskController.toggleTaskCompletion(index);
        },
        icon: Icon(task.isCompleted ? Icons.task_alt : Icons.circle_outlined),
        color: task.isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.content,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const Divider(),
          Row(
            children: [
              Text(
                '${task.dueDate.toLocal()}'.substring(0, 16),
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
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
