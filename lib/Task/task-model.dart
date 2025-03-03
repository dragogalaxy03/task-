class Task {
  String taskName;
  String priority;
  String date;
  String description;
  String location;
  String assignedTo;
  String status;

  Task({
    required this.taskName,
    required this.priority,
    required this.date,
    required this.description,
    required this.location,
    required this.assignedTo,
    required this.status,
  });

  // ✅ Add copyWith method
  Task copyWith({
    String? taskName,
    String? priority,
    String? date,
    String? description,
    String? location,
    String? assignedTo,
    String? status,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      description: description ?? this.description,
      location: location ?? this.location,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
    );
  }
}
