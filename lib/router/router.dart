import 'package:go_router/go_router.dart';
import 'package:productivity/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity/pages/tasks.dart';
import 'package:productivity/pages/user.dart';
import '../widgets/navbar.dart';
import '../pages/home.dart';


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => Navbar(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage()
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => TasksPage()
          ),
          GoRoute(
            path: '/user',
            builder: (context, state) => UserPage()
          )
        ]
      ),
    ]
  );
});

