import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomeScreen> {

  String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  String time = DateFormat('hh:mm a').format(DateTime.now());
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    if (this.mounted) {
      setState(() {
        date = DateFormat.yMMMMEEEEd().format(DateTime.now());
        time = DateFormat('hh:mm a').format(DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Text(date.toString()),
            Text(
              time.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}


