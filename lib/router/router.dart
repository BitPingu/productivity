import 'package:go_router/go_router.dart';
import 'package:productivity/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/screens/home_screen.dart';
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
            builder: (context, state) => HomeScreen()
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => TasksScreen()
          ),
          GoRoute(
            path: '/user',
            builder: (context, state) => UserScreen()
          )
        ]
      ),
    ]
  );
});


