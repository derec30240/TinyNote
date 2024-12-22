import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/pages/widgets/task_card.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (taskController.tasks.isEmpty) {
        return const Center(
          child: Text(
            'No tasks yet.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            String uuid = taskController.tasks[index].uuid;
            return Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                extentRatio: 0.25,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(15),
                    autoClose: true,
                    onPressed: (context) => taskController.deleteTask(uuid),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: TaskCard(uuid: uuid),
            ).animate().fade().slide(duration: Duration(milliseconds: 300));
          },
        ),
      );
    });
  }
}
