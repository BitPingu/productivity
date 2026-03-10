import 'package:go_router/go_router.dart';
import 'package:productivity/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/router/CustomTransitionPage.dart';
import 'package:productivity/screens/home_screen.dart';
import 'package:productivity/screens/new_task_screen.dart';
import 'package:productivity/screens/tasks_screen.dart';
import 'package:productivity/screens/user_screen.dart';
import 'package:productivity/widgets/navbar.dart';


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => Navbar(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: HomeScreen()
            )
          ),
          GoRoute(
            path: '/tasks',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: TasksScreen()
            )
          ),
          GoRoute(
            path: '/user',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: UserScreen()
            )
          ),
          GoRoute(
            path: '/new-task',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: NewTaskScreen()
            )
          )
        ]
      ),
    ]
  );
});


