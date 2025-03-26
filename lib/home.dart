import 'package:flutter/material.dart';
import 'package:hivetest1/boxes.dart';
import 'package:hivetest1/tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final addtask = TextEditingController();
  int? sindex;
  bool checkupdate = false;
  final addtaskfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('To-Do App'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: tasksbox.length,
              itemBuilder: (context, index) {
                Tasks taskitem = tasksbox.getAt(index);
                return Row(
                  children: [
                    Checkbox(
                      value: taskitem.taskcheck,
                      onChanged: (checked) {
                        setState(() {
                          taskitem.taskcheck = checked!;
                          if (taskitem.taskcheck == true) {
                            tasksbox.putAt(
                                index,
                                Tasks(
                                    taskname: taskitem.taskname,
                                    taskcheck: true));
                          } else {
                            tasksbox.putAt(
                                index,
                                Tasks(
                                    taskname: taskitem.taskname,
                                    taskcheck: false));
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: Card(
                        color: sindex == tasksbox.keyAt(index)
                            ? Color.fromRGBO(230, 230, 250, 1)
                            : Colors.white,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (sindex == null) {
                                sindex = tasksbox.keyAt(index);
                                checkupdate = taskitem.taskcheck;
                                addtask.text = taskitem.taskname;
                              } else {
                                addtask.text = '';
                                sindex = null;
                              }
                            });
                          },
                          title: Text(
                            taskitem.taskname,
                            style: TextStyle(
                                decoration: taskitem.taskcheck
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton.small(
                      child: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          tasksbox.deleteAt(index);
                        });
                      },
                    )
                  ],
                );
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (addtask.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(microseconds: 800000),
                              showCloseIcon: false,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: 130),
                              content: Text('Text field cannot be empty')));
                        } else {
                          tasksbox.add(
                              Tasks(taskname: addtask.text, taskcheck: false));
                          addtask.clear();
                          addtaskfocus.unfocus();
                        }
                      });
                    },
                    child: Text('Add')),
                ElevatedButton(
                    onPressed: sindex == null
                        ? null
                        : () {
                            setState(() {
                              tasksbox.put(
                                  sindex,
                                  Tasks(
                                      taskname: addtask.text,
                                      taskcheck: checkupdate));
                              addtask.clear();
                              addtaskfocus.unfocus();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(microseconds: 800000),
                                      showCloseIcon: false,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(bottom: 130),
                                      content: Text('Task has been updated')));
                              sindex = null;
                            });
                          },
                    child: Text('Update'))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextField(
                    focusNode: addtaskfocus,
                    decoration: InputDecoration(
                        hintText: 'Add a task...',
                        fillColor: Color.fromRGBO(214, 202, 221, 1),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        border: OutlineInputBorder()),
                    controller: addtask,
                  ),
                )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30))
          ],
        ));
  }
}
