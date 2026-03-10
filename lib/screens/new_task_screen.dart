import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(
                bottom: 8
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                        onPressed: context.pop,
                        icon: Icon(
                          Icons.close,
                          size: 22,
                        )
                      ),
                      SizedBox(width: 3),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 2.0,
                    ),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {}, 
                        child: Text(
                          "Save"
                        )
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


