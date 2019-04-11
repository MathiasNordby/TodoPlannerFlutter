import 'package:flutter/material.dart';
import 'todoListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
