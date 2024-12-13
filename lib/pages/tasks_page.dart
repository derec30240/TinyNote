import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/models/task.dart';
import 'package:tiny_note/pages/task_edit_page.dart';

class TaskPage extends StatelessWidget {
  final TaskController taskController = Get.find();

  TaskPage({super.key});

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
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(15),
                        autoClose: true,
                        onPressed: (context) => Get.to(() => TaskEditPage(
                              task: task,
                              index: index,
                            )),
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
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
                ).animate().fade().slide(duration: 300.ms);
              },
            ),
          ));
  }

  /// Every task have its owm card showed on the page.
  Widget taskCard(Task task, int index) {
    return Card(
      elevation: 7, //set the size of shade
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: IconButton(
          onPressed: () => taskController.toggleTaskCompletion(index),
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
            const Divider(),
            Text(
              task.content,
              style: TextStyle(
                color: Colors.grey.shade600,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const Divider(),
            Text(
              '${task.dueDate.toLocal()}'.substring(0, 16),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
