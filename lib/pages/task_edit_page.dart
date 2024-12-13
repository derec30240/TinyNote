import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/task_conotroller.dart';
import 'package:tiny_note/models/task.dart';

class TaskEditPage extends StatelessWidget {
  final TaskController taskController = Get.find();
  final Task? task;
  final int? index;

  TaskEditPage({
    super.key,
    this.index,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    titleController.text = (task == null) ? '' : task!.title;
    final TextEditingController contentController = TextEditingController();
    contentController.text = (task == null) ? '' : task!.content;
    DateTime? selectedDate;
    selectedDate = (task == null) ? null : task!.dueDate;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(task == null ? 'New task' : 'Edit task'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                label: Text(
                  (selectedDate == null)
                      ? "Pick a Due Date"
                      : '${selectedDate.toLocal()}'.split(' ')[0],
                ),
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      contentController.text.isEmpty ||
                      selectedDate == null) {
                    final taskAddFailSnackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text(
                          'Fail to add the task. Please fill in all fields.'),
                      action: SnackBarAction(label: 'CLose', onPressed: () {}),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(taskAddFailSnackBar);
                  }
                  if (task == null) {
                    taskController.addTask(Task(
                        title: titleController.text,
                        content: contentController.text,
                        dueDate: selectedDate!));
                    Get.back();
                    final taskAddSnackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Task added.'),
                      action: SnackBarAction(label: 'Close', onPressed: () {}),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(taskAddSnackBar);
                  } else {
                    taskController.editTask(
                        index!,
                        Task(
                            title: titleController.text,
                            content: contentController.text,
                            dueDate: selectedDate!,
                            isCompleted: task!.isCompleted));
                    Get.back();
                    final taskAddSnackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Task edited.'),
                      action: SnackBarAction(label: 'Close', onPressed: () {}),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(taskAddSnackBar);
                  }
                },
                child: Text((task == null) ? 'Add task' : 'Edit task'),
              ),
            ],
          )),
    );
  }
}
