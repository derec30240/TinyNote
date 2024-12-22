import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:tiny_note/models/task.dart';

class TaskController extends GetxController {
  List tasks = <Task>[].obs;
  List<String> get taskTitles => [for (Task task in tasks) task.title];

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tasks')) {
      List<String> tasksStringList = prefs.getStringList('tasks')!;
      tasks.assignAll(tasksStringList
          .map((taskString) => Task.fromJson(json.decode(taskString)))
          .toList());
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskStringList =
        tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', taskStringList);
  }

  void addTask(String title, String content, DateTime dueDate) {
    Uuid uuid = const Uuid();
    tasks.add(Task(
      uuid: uuid.v4(),
      title: title,
      content: content,
      dueDate: dueDate,
    ));
    update();
    _saveTasks();
  }

  void deleteTask(String uuid) {
    tasks.removeWhere((task) => task.uuid == uuid);
    update();
    _saveTasks();
  }

  void editTask(String uuid, String title, String content, DateTime dueDate) {
    int index = tasks.indexWhere((task) => task.uuid == uuid);
    if (index != -1) {
      Task oldTask = tasks[index];
      tasks[index] = Task(
        uuid: oldTask.uuid,
        title: title,
        content: content,
        dueDate: dueDate,
      );
    }
    update();
    _saveTasks();
  }

  void toggleTaskCompletion(String uuid) {
    int index = tasks.indexWhere((task) => task.uuid == uuid);
    tasks[index].isCompleted = !tasks[index].isCompleted;
    update();
    _saveTasks();
  }
}
