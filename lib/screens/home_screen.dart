import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:productivity/models/task.dart';
import 'package:productivity/providers/task_provider.dart';
import 'package:productivity/widgets/task_tile.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomeScreen> {
  String date = DateFormat.MMMMEEEEd().format(DateTime.now());
  String greeting = '';
  String imgPath = '';

  @override
  void initState() {
    super.initState();
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour <= 12) {
      greeting = 'morning';
      imgPath = 'images/morning.jpg';
    } else if (hour >= 12 && hour <= 16 ) {
      greeting = 'afternoon';
      imgPath = 'images/afternoon.jpg';
    } else if (hour >= 16 && hour <= 21) {
      greeting = 'evening';
      imgPath = 'images/evening.jpg';
    } else {
      greeting = 'night';
      imgPath = 'images/night.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = ref.watch(tasksProvider).tasks;
    final List<int> colorCodes = <int>[600, 500, 100];
    final listKey = GlobalKey<AnimatedListState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Text(
              'Good $greeting, Gavin!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'It is currently ${date.toString()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 10),
            Image.asset(imgPath),
            const SizedBox(height: 15),

            tasks.length > 1
            ? Text("${tasks.length} incentives left for today! Keep it up!")
            : tasks.length == 1 
            ? Text("${tasks.length} incentive left for today! Almost there!")
            : Text("No incentives left for today! Hooray!"),

            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: tasks.length.toDouble(),
                  end: tasks.length/3,
                ), 
                duration: const Duration(milliseconds: 150), 
                builder: (context, value, _) =>
                  LinearProgressIndicator(
                    value: value,
                    color: Colors.cyanAccent[400],
                  ),
              ),
            ),

            const SizedBox(height: 12),

            AnimatedList.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                key: listKey,
                padding: const EdgeInsets.symmetric(horizontal: 26),
                initialItemCount: tasks.length,
                itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                  final task = tasks[index];
                  return TaskTile(
                    task: tasks[index],
                    animation: animation,
                    onClicked: () {
                      // task complete
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
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.cyan[400],
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
              ),
              const SizedBox(height: 70)
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


