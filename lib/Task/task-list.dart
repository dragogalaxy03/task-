import 'package:flutter/material.dart';
import 'package:taskcard/Task/task-card.dart';
import 'package:taskcard/Task/task-json.dart';
import 'package:taskcard/Task/task-model.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = TaskJson.exampleTasks;

  void _updateTaskStatus(int index, String newStatus, String newPriority) {
    setState(() {
      tasks[index] = tasks[index].copyWith(status: newStatus, priority: newPriority);
    });
  }

  void _updateAssignedTo(int index, String newAssignedTo) {
    setState(() {
      tasks[index] = tasks[index].copyWith(assignedTo: newAssignedTo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: const Text("Task List")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(
            task: tasks[index],
            onStatusChanged: (newStatus, newPriority) =>
                _updateTaskStatus(index, newStatus, newPriority),
            onAssignEmployee: (newAssignedTo) => _updateAssignedTo(index, newAssignedTo), // ✅ Update assigned employee
          );
        },
      ),
    );
  }
}
