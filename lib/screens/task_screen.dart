import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ikigai/models/task.dart';
import 'package:ikigai/providers/task_provider.dart';


class TaskScreen extends ConsumerWidget {
  final String? taskId;

  const TaskScreen({super.key, this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = taskId != null ? ref.watch(tasksProvider).getTask(taskId ?? "").title : "";
    final TextEditingController _inputController = TextEditingController(text: text);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 60.0),
              Text(
                taskId == null ? "New task!" : "Edit task",
                style: TextStyle(
                  color: !isDarkMode ? Colors.black87 : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              taskId != null
              ?
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          "Are you sure you want to delete this task?",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text(
                              'No',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.read(tasksProvider).removeTask(taskId ?? "");
                              context.pop();
                              context.pop();
                            },
                            child: const Text(
                              'Yes',
                            ),
                          )
                        ],
                      );
                    }
                  ),
                  icon: Icon(
                    Icons.delete,
                    size: 24.0,
                    color: Colors.red[700],
                  )
                ),
              )
              :
              const SizedBox(width: 60.0),
            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 26.0,
              vertical: 16.0,
            ),
            padding: const EdgeInsets.only(
              bottom: 6.0
            ),
            decoration: BoxDecoration(
              color: !isDarkMode ? Colors.white : Colors.grey[800],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: context.pop,
                      icon: Icon(
                        Icons.close,
                        size: 20.0,
                      )
                    ),
                    SizedBox(width: 3.0),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    // vertical: 8.0
                  ),
                  child: TextField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _inputController,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: !isDarkMode ? Colors.black87 : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "What do you want to do?",
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Row(
                  children: [
                    Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _inputController, 
                      builder: (context, value, child) {
                        return TextButton(
                          style: value.text.isNotEmpty ? ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.tealAccent[400]),
                            foregroundColor: WidgetStatePropertyAll(Colors.white)
                          ) : null,
                          onPressed: value.text.isNotEmpty ? () {
                            if (taskId == null) {
                              ref.read(tasksProvider).addTask(
                                Task(
                                  id: ref.read(tasksProvider).tasks.length.toString(), 
                                  title: _inputController.text, 
                                  subtitle: "10 EXP",
                                  exp: 10, 
                                  isDone: false
                                )
                              );
                            } else {
                              ref.read(tasksProvider).editTask(
                                Task(
                                  id: taskId ?? "", 
                                  title: _inputController.text, 
                                  subtitle: ref.read(tasksProvider).getTask(taskId ?? "").subtitle,
                                  exp: ref.read(tasksProvider).getTask(taskId ?? "").exp, 
                                  isDone: false
                                )
                              );
                            }
                            context.pop();
                          } : null, 
                          child: Text(
                            "Save",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        );
                      }
                    ),
                    SizedBox(width: 6.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


