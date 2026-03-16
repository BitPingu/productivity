import 'package:go_router/go_router.dart';
import 'package:ikigai/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikigai/router/CustomTransitionPage.dart';
import 'package:ikigai/screens/home_screen.dart';
import 'package:ikigai/screens/task_screen.dart';
import 'package:ikigai/screens/user_screen.dart';
import 'package:ikigai/widgets/navbar.dart';


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
              child: TaskScreen()
            )
          ),
          GoRoute(
            path: '/new-task/:taskId',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: TaskScreen(taskId: state.pathParameters['taskId'])
            )
          )
        ]
      ),
    ]
  );
});


