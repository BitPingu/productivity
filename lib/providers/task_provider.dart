import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikigai/models/task.dart';

class TaskNotifier extends ChangeNotifier {
  final List<Task> _tasks = [
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

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void editTask(Task task) {
    int index = _tasks.indexWhere((item) => item.id == task.id);
    _tasks[index] = task;
    notifyListeners();
  }

  Task getTask(String taskId) {
    Task task = _tasks.firstWhere((item) => item.id == taskId);
    return task;
  }

  void removeTask(String taskId) {
    toggle(taskId);
    _tasks.removeWhere((task) => task.id == taskId);
    // notifyListeners();
  }

  void toggle(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.isDone = !task.isDone;
    // notifyListeners();
  }

  void delayedNotify() {
    notifyListeners();
  }
}

final tasksProvider = ChangeNotifierProvider<TaskNotifier>((ref) => TaskNotifier());


