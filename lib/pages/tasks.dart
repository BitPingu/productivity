import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<String> entries = <String>[
      'Drink water', 
      'Get out of bed', 
      'Wash my face'
    ];
    final List<String> entries2 = <String>[
      '10 EXP', 
      '100 EXP', 
      '20 EXP'
    ];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: 0),
                  SizedBox(height: 4),
                  Text("${entries.length} tasks to complete!"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 2.0,
                      ),
                      title: Text(
                        entries[index],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        entries2[index],
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Container(
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
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
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

