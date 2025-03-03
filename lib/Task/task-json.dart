import 'dart:convert';
import 'package:taskcard/Task/task-model.dart';

class TaskJson {
  /// Convert Task object to JSON
  static Map<String, dynamic> toJson(Task task) {
    return {
      'taskName': task.taskName,
      'priority': task.priority,
      'date': task.date,
      'description': task.description,
      'location': task.location,
      'assignedTo': task.assignedTo,
      'status': task.status, // ✅ Ensure status is included
    };
  }

  /// Convert JSON to Task object
  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['taskName'] ?? '',
      priority: json['priority'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      status: json['status'] ?? 'Pending', // ✅ Default to Pending if not provided
    );
  }

  /// Convert Task object to JSON string
  static String toJsonString(Task task) {
    return jsonEncode(toJson(task));
  }

  /// Convert JSON string to Task object
  static Task fromJsonString(String jsonString) {
    return fromJson(jsonDecode(jsonString));
  }

  /// Example Tasks with Different Statuses
  static List<Task> exampleTasks = [
    Task(
      taskName: "Complete UI Design",
      priority: "High",
      date: "March 5, 2025",
      description: "Design the main dashboard UI for the app",
      location: "Remote",
      assignedTo: "Ashish Kumar",
      status: "Pending",
    ),
    Task(
      taskName: "Develop API",
      priority: "Medium",
      date: "March 6, 2025",
      description: "Develop REST APIs for user authentication",
      location: "On-Site",
      assignedTo: "John Doe",
      status: "In Progress",
    ),
    Task(
      taskName: "Testing Phase",
      priority: "Low",
      date: "March 10, 2025",
      description: "Perform UI/UX and functional testing",
      location: "Remote",
      assignedTo: "Jane Smith",
      status: "Completed",
    ),
  ];
}
