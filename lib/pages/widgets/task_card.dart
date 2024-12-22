import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/models/task.dart';
import 'package:tiny_note/pages/task_edit_page.dart';
import 'package:tiny_note/controllers/task_conotroller.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final int index;
  const TaskCard({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        onTap: () {
          Get.to(() => TaskEditPage(
                task: widget.task,
                index: widget.index,
              ));
        },
        leading: IconButton(
          onPressed: () {
            taskController.toggleTaskCompletion(widget.index);
            setState(() {});
          },
          icon: Icon(
              widget.task.isCompleted ? Icons.task_alt : Icons.circle_outlined),
          color: widget.task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          widget.task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                widget.task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.content,
              style: TextStyle(
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  '${widget.task.dueDate.toLocal()}'.substring(0, 16),
                  style: TextStyle(
                    decoration: widget.task.isCompleted
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
