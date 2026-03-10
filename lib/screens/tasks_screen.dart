import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:productivity/models/task.dart';
import 'package:productivity/providers/task_provider.dart';
import 'package:productivity/widgets/task_tile.dart';


class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> tasks = ref.watch(tasksProvider).tasks;
    final List<int> colorCodes = <int>[600, 500, 100];
    final listKey = GlobalKey<AnimatedListState>();

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
                      LinearProgressIndicator(
                        value: value,
                        color: Colors.cyanAccent[400],
                      ),
                  ),
                  SizedBox(height: 4),
                  tasks.length != 1
                  ? Text("${tasks.length} incentives to complete!")
                  : Text("${tasks.length} incentive to complete!")
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: 
              tasks.isNotEmpty 
              ? AnimatedList.separated(
                  key: listKey,
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  initialItemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                    final task = tasks[index];
                    return TaskTile(
                      task: tasks[index],
                      animation: animation,
                      onClicked: () {
                        // Implement task completion logic
                        final removedItem = tasks[index];
                        listKey.currentState!.removeItem(
                          index, 
                          (context, animation) => TaskTile(
                            task: removedItem, 
                            animation: animation,
                            onClicked: () {},
                          ),
                          duration: Duration(milliseconds: 150),
                        );
                        ref.read(tasksProvider).removeTask(task.id);
                        Future.delayed(Duration(milliseconds: 150), () {
                          ref.read(tasksProvider).delayedNotify();
                          Fluttertoast.showToast(
                            msg: "Task completed! Gained ${task.exp} EXP.",
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.indigo[400],
                            textColor: Colors.white
                          );
                        });
                      }
                    );
                  },
                  separatorBuilder: (BuildContext context, int index, Animation<double> animation) => const SizedBox(
                    height: 6
                  ),
                  removedSeparatorBuilder: (BuildContext context, int index, Animation<double> animation) => const SizedBox(
                    height: 6
                  ),
                )
              : Center(
                  child: Text(
                    'No incentives left for today. Hooray!',
                  ),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent[400],
        onPressed: () {
          context.push('/new-task');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 27,
        ),
      ),
    );
  }
}


