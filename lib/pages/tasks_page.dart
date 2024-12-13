import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/models/task.dart';
import 'package:tiny_note/pages/task_edit_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => (taskController.tasks.isEmpty)
        ? const Center(
            child: Text(
              'No tasks yet.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: taskController.tasks.length,
              itemBuilder: (context, index) {
                Task task = taskController.tasks[index];
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(15),
                        autoClose: true,
                        onPressed: (context) =>
                            taskController.deleteTask(index),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: taskCard(task, index),
                ).animate().fade().slide(duration: Duration(milliseconds: 300));
              },
            ),
          ));
  }

  /// Every task have its owm card showed on the page.
  Widget taskCard(Task task, int index) {
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
            setState(() {});
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
}
