import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/models/task.dart';
import 'package:productivity/providers/task_provider.dart';
import 'package:productivity/widgets/task_tile.dart';


class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> tasks = ref.watch(tasksProvider).tasks;
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: tasks.length.toDouble(),
                      end: tasks.length.toDouble()/3,
                    ), 
                    duration: const Duration(milliseconds: 150), 
                    builder: (context, value, _) =>
                      LinearProgressIndicator(value: value),
                  ),
                  SizedBox(height: 4),
                  tasks.length != 1
                  ? Text("${tasks.length} tasks to complete!")
                  : Text("${tasks.length} task to complete!")
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: 
              tasks.isNotEmpty 
              ? AnimatedList.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  initialItemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                    final task = tasks[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[colorCodes[index]],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TaskTile(
                        task: tasks[index],
                        animation: animation,
                        onChanged: () {
                          // Implement task completion logic
                          AnimatedList.of(context).removeItem(
                            index, 
                            (context, animation) => TaskTile(
                              task: task, 
                              animation: animation, 
                              onChanged: () {},
                            ),
                            duration: Duration(milliseconds: 1200),
                          );
                          ref.read(tasksProvider).removeTask(task.id);
                        }
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index, Animation<double> animation) => const SizedBox(
                    height: 10
                  ),
                  removedSeparatorBuilder: (BuildContext context, int index, Animation<double> animation) => const SizedBox(
                    height: 10
                  ),
                )
              : Center(
                  child: Text(
                    'No tasks left for today. Hooray!',
                  ),
                ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}


