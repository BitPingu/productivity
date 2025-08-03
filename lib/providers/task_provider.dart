import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/models/task.dart';

class TaskNotifier extends ChangeNotifier {
  List<Task> tasks = [
    Task(
      id: '0', 
      title: 'Drink water', 
      subtitle: '10 EXP',
      isDone: false
    ),
    Task(
      id: '1', 
      title: 'Get out of bed', 
      subtitle: '100 EXP',
      isDone: false
    ),
    Task(
      id: '2', 
      title: 'Wash my face', 
      subtitle: '20 EXP',
      isDone: false
    ), 
  ];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(String taskId) {
    // TODO: remove later (temp placement)
    toggle(taskId);
    tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void toggle(String taskId) {
    final task = tasks.firstWhere((task) => task.id == taskId);
    task.isDone = !task.isDone;
    notifyListeners();
  }
}

// Implement methods to update and delete tasks

// You can also add methods for fetching and managing tasks


final tasksProvider = ChangeNotifierProvider<TaskNotifier>((ref) => TaskNotifier());


