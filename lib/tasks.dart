import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 1)
class Tasks {
  @HiveField(0)
  String taskname;

  @HiveField(1)
  bool taskcheck;
  Tasks({required this.taskname, required this.taskcheck});
}
