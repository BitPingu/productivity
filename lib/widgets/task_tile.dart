import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ikigai/models/task.dart';


class TaskTile extends ConsumerWidget {
  final Task task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const TaskTile({
    super.key,
    required this.task,
    required this.animation,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizeTransition(
    sizeFactor: animation,
    child: buildItem(context, ref),
  );

  Widget buildItem(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: !isDarkMode ? Colors.cyan[50] : Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 2.0,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: !isDarkMode ? Colors.black87 : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${task.exp} EXP",
          style: TextStyle(
            color: !isDarkMode ? Colors.black87 : Colors.white,
          ),
        ),
        onTap: () {
          context.push("/new-task/${task.id}");
        },
        trailing: Stack(
          children: [
            Positioned(
              top: 4,
              left: 3,
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: !task.isDone ? Colors.tealAccent[400] : Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: !task.isDone ? Colors.white : Colors.tealAccent[400],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  onPressed: onClicked,
                  icon: Icon(
                    Icons.check,
                    color: !task.isDone ? Colors.tealAccent[400] : Colors.white,
                    size: 27.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ); 
  }
}

