import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Navbar extends StatelessWidget {
  final Widget child;

  const Navbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/tasks');
                break;
              case 2:
                context.go('/user');
                break;
            }
        },
        indicatorColor: Colors.amber,
        selectedIndex: _getSelectedIndex(context),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined), 
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.format_list_bulleted),
            icon: Icon(Icons.format_list_bulleted), 
            label: 'Tasks',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline), 
            label: 'You',
          ),
        ]
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/') return 0;
    if (location == '/tasks') return 1;
    if (location == '/user') return 2;
    return 0;
  }
}

