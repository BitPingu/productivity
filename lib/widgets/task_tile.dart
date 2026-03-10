import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/models/task.dart';


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

  Widget buildItem(BuildContext context, WidgetRef ref) => Container(
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 2.0,
      ),
      title: Text(
        task.title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${task.exp} EXP",
        style: const TextStyle(
          color: Colors.black87,
        ),
      ),
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
            ),
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: !task.isDone ? Colors.white : Colors.tealAccent[400],
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
              child: IconButton(
                onPressed: onClicked,
                icon: Icon(
                  Icons.check,
                  color: !task.isDone ? Colors.tealAccent[400] : Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
      ),
    )
  );
  }


