import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ikigai/models/task.dart';
import 'package:ikigai/providers/task_provider.dart';
import 'package:ikigai/widgets/task_tile.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomeScreen> {
  String date = DateFormat.MMMMEEEEd().format(DateTime.now());
  String greeting = "";
  String imgPath = "";
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      greeting = "morning";
      imgPath = "images/morning.jpg";
    } else if (hour >= 12 && hour < 17 ) {
      greeting = "afternoon";
      imgPath = "images/afternoon.jpg";
    } else if (hour >= 17 && hour < 22) {
      greeting = "evening";
      imgPath = "images/evening.jpg";
    } else {
      greeting = "night";
      imgPath = "images/night.jpg";
    }
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<Task> tasks = ref.watch(tasksProvider).tasks;
    final listKey = GlobalKey<AnimatedListState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Text(
              "Good $greeting, Gavin!",
              style: TextStyle(
                color: !isDarkMode ? Colors.black87 : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Text(
              "It is currently ${date.toString()}",
              style: TextStyle(
                color: !isDarkMode ? Colors.black87 : Colors.white,
                fontSize: 16.0,
              ),
            ),

            const SizedBox(height: 10.0),
            Image.asset(imgPath),
            const SizedBox(height: 15.0),

            tasks.length > 1
            ? Text("${tasks.length} tasks left for today! Keep it up!")
            : tasks.length == 1 
            ? Text("${tasks.length} task left for today! Almost there!")
            : Text("All tasks complete! Good job!"),

            const SizedBox(height: 6.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
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

            const SizedBox(height: 12.0),

            AnimatedList.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                key: listKey,
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
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
                        fToast.showToast(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.lightGreen,
                            ),
                            child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                width: 12.0,
                                ),
                                Text(
                                  "Task completed! Gained ${task.exp} EXP.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                            ],
                            ),
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: Duration(seconds: 2),
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
              const SizedBox(height: 70.0)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent[400],
        onPressed: () {
          context.push("/new-task");
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


