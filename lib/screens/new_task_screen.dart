import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:productivity/models/task.dart';
import 'package:productivity/providers/task_provider.dart';


class NewTaskScreen extends ConsumerWidget {
  NewTaskScreen({super.key});

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          Text(
            'New incentive!',
            style: Theme.of(context).textTheme.headlineSmall,
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                        size: 20,
                      )
                    ),
                    SizedBox(width: 3),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    // vertical: 8.0
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: _inputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'What do you want to achieve?',
                    ),
                  ),
                ),
                SizedBox(width: 6),
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
                            ref.read(tasksProvider).addTask(
                              Task(
                                id: ref.watch(tasksProvider).tasks.length.toString(), 
                                title: _inputController.text, 
                                subtitle: '10 EXP',
                                exp: 10, 
                                isDone: false
                              )
                            );
                            context.pop();
                          } : null, 
                          child: Text(
                            "Save",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        );
                      }
                    ),
                    SizedBox(width: 6),
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


