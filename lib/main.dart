import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivetest1/boxes.dart';
import 'package:hivetest1/home.dart';
import 'package:hivetest1/tasks.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  tasksbox = await Hive.openBox<Tasks>('tasksbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home());
  }
}
