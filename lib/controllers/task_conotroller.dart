import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_note/models/task.dart';

class TaskController extends GetxController {
  List tasks = <Task>[].obs;

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

  void addTask(Task task) {
    tasks.add(task);
    update();
    _saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    update();
    _saveTasks();
  }

  void editTask(int index, Task newTask) {
    tasks[index] = newTask;
    update();
    _saveTasks();
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    _saveTasks();
  }
}
