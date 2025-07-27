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
                context.go('/account');
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
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.person_outline), 
            label: 'Account',
          ),
        ]
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/') return 0;
    if (location == '/account') return 1;
    return 0;
  }
}

