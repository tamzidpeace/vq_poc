import 'package:flutter/material.dart';
import 'package:vq_poc/debounce_test.dart';
import 'package:vq_poc/enter_mode.dart';
import 'package:vq_poc/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VQ POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Test(),
      // EnterMode(title: 'VQ POC Enter Mode'),
      // Debounce(),
    );
  }
}
