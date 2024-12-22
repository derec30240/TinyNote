import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/controllers/task_conotroller.dart';

class TaskEditPage extends StatefulWidget {
  final String uuid;

  const TaskEditPage({
    super.key,
    required this.uuid,
  });

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.uuid != '') {
      int index =
          taskController.tasks.indexWhere((task) => task.uuid == widget.uuid);
      titleController.text = taskController.tasks[index].title;
      contentController.text = taskController.tasks[index].content;
      selectedDate = taskController.tasks[index].dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.uuid == '' ? 'New task' : 'Edit task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
            Row(
              children: [
                TextButton.icon(
                  label: Text(
                    (selectedDate == null)
                        ? "Pick a Due Date"
                        : '${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: (selectedDate == null)
                          ? DateTime.now()
                          : selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = (selectedDate == null)
                            ? DateTime(
                                picked.year,
                                picked.month,
                                picked.day,
                                DateTime.now().hour,
                                DateTime.now().minute,
                              )
                            : DateTime(
                                picked.year,
                                picked.month,
                                picked.day,
                                selectedDate!.hour,
                                selectedDate!.minute,
                              );
                      });
                    }
                  },
                ),
                TextButton.icon(
                  label: Text(
                    (selectedDate == null)
                        ? "Pick a Due Time"
                        : '${selectedDate!.toLocal()}'.substring(11, 16),
                  ),
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: (selectedDate == null)
                          ? TimeOfDay.now()
                          : TimeOfDay.fromDateTime(selectedDate!),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = (selectedDate == null)
                            ? DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                picked.hour,
                                picked.minute)
                            : DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                picked.hour,
                                picked.minute,
                              );
                      });
                    }
                  },
                ),
              ],
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
                    action: SnackBarAction(label: 'Close', onPressed: () {}),
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(taskAddFailSnackBar);
                  return;
                }
                if (widget.uuid == '') {
                  taskController.addTask(titleController.text,
                      contentController.text, selectedDate!);
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
                    widget.uuid,
                    titleController.text,
                    contentController.text,
                    selectedDate!,
                  );
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
              child: Text((widget.uuid == '') ? 'Add task' : 'Edit task'),
            ),
          ],
        ),
      ),
    );
  }
}
