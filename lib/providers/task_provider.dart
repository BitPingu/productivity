import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/models/task.dart';

class TaskNotifier extends ChangeNotifier {
  List<Task> tasks = [
    Task(
      id: '0',
      exp: 10,
      title: 'Drink water', 
      subtitle: '10 EXP',
      isDone: false
    ),
    Task(
      id: '1',
      exp: 100,
      title: 'Get out of bed',
      subtitle: '100 EXP',
      isDone: false
    ),
    Task(
      id: '2',
      exp: 20,
      title: 'Wash my face',
      subtitle: '20 EXP',
      isDone: false
    ),
    // Task(
    //   id: '3',
    //   exp: 40,
    //   title: 'Take 3 deep breaths',
    //   subtitle: '40 EXP',
    //   isDone: false
    // ),
    // Task(
    //   id: '4',
    //   exp: 15,
    //   title: 'Brush teeh',
    //   subtitle: '15 EXP',
    //   isDone: false
    // ),
  ];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(String taskId) {
    toggle(taskId);
    tasks.removeWhere((task) => task.id == taskId);
    // notifyListeners();
  }

  void toggle(String taskId) {
    final task = tasks.firstWhere((task) => task.id == taskId);
    task.isDone = !task.isDone;
    // notifyListeners();
  }

  void delayedNotify() {
    notifyListeners();
  }
}

// Implement methods to update and delete tasks

// You can also add methods for fetching and managing tasks


final tasksProvider = ChangeNotifierProvider<TaskNotifier>((ref) => TaskNotifier());


