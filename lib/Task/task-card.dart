import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:taskcard/Task/task-model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Function(String, String) onStatusChanged;
  final Function(String newAssignedTo)? onAssignEmployee;

  const TaskCard({Key? key, required this.task, required this.onStatusChanged, this.onAssignEmployee})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String assignedTo = "Unassigned";
  String assignOption = "Self";
  bool showAssignOptions = false;
  late String status;
  late String priority;

  final TextEditingController noteController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];

  @override
  void initState() {
    super.initState();
    status = widget.task.status ?? "Pending";
    priority = widget.task.priority;
  }

  //File Picker
  Future<void> _pickAttachments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        for (var file in result.files) {
          if (!_selectedFiles.any((f) => f.name == file.name)) {
            _selectedFiles.add(file);
          }
        }
      });
    }
  }

  //File remove
  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title & Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.task.taskName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: priorityColor(priority),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    priority,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Task Details
            _buildTaskDetail(Icons.calendar_today, "Date", widget.task.date),
            _buildTaskDetail(Icons.location_on, "Location", widget.task.location),
            _buildTaskDetail(Icons.description, "Description", widget.task.description),
            _buildTaskDetail(Icons.person, "Assigned To", assignedTo, isBold: true),
            const SizedBox(height: 16),
            //Radio Buttons
            if (showAssignOptions)
              Row(children: [_buildRadioOption("Self"), _buildRadioOption("Employee")]),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  "Assign",
                      () => setState(() => showAssignOptions = true),
                ),

                _buildButton(
                  status,
                      () => _showStatusDialog(context),
                  color: statusColor(status),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Prevents extra space
                    children: [
                      const Icon(Icons.edit, size: 18, color: Colors.white), // Edit icon
                      const SizedBox(width: 6), // Space between icon and text
                      Text(status, style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  //Building Task Details
  Widget _buildTaskDetail(IconData icon, String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
  //Building RadioButtons
  Widget _buildRadioOption(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: assignOption,
          onChanged: (val) {
            setState(() {
              assignOption = val.toString();
              assignedTo = value == "Self" ? "Self" : "Unassigned";
              if (value == "Employee") _showEmployeePicker(context);
              showAssignOptions = false;
            });
          },
        ),
        Text(value),
      ],
    );
  }
  //Show BottomSheet here
  void _showEmployeePicker(BuildContext context) async {
    List<Map<String, String>> employees = [
      {"name": "John Doe", "image": "https://randomuser.me/api/portraits/men/1.jpg"},
      {"name": "Jane Smith", "image": "https://randomuser.me/api/portraits/women/2.jpg"},
      {"name": "Michael Brown", "image": "https://randomuser.me/api/portraits/men/3.jpg"},
      {"name": "Emily Davis", "image": "https://randomuser.me/api/portraits/women/4.jpg"},
      {"name": "David Wilson", "image": "https://randomuser.me/api/portraits/men/5.jpg"},
    ]; // Example employees with images

    String? selectedEmployee = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row with Title & Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select an Employee",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 24, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Employee List
              Expanded(
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(employees[index]["image"]!), // Employee image
                          radius: 28,
                        ),
                        title: Text(
                          employees[index]["name"]!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context, employees[index]["name"]); // ✅ Return selected employee
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );

      },
    );

    // ✅ Handle the selected employee
    if (selectedEmployee != null) {
      setState(() {
        assignedTo = selectedEmployee; // Update the assigned employee in your UI
      });
    }
  }
  //Show Status Dialog -- Can change status here
  void _showStatusDialog(BuildContext context) {
    String newStatus = status;
    String newPriority = priority;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Task Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: newStatus,
                items: ["Pending", "In Progress", "Completed"].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    newStatus = value!;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              /// Note Field
              const Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Write any additional notes...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              /// Attachments Section
              const Text("Attach a File", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              InkWell(
                onTap: _pickAttachments,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 0.8),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _selectedFiles.isNotEmpty
                              ? "${_selectedFiles.length} file(s) selected"
                              : "No files selected",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.attach_file, color: Colors.blue),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              /// Display selected files
              if (_selectedFiles.isNotEmpty)
                Column(
                  children: _selectedFiles.asMap().entries.map((entry) {
                    int index = entry.key;
                    PlatformFile file = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.insert_drive_file, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              file.name,
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red, size: 18),
                            onPressed: () => _removeFile(index),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  status = newStatus;
                });
                widget.onStatusChanged(newStatus, newPriority);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Change button color
                foregroundColor: Colors.white, // Change text color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text("Update"),
            ),


          ],
        );
      },
    );
  }
  //Building Buttons
  Widget _buildButton(String text, VoidCallback onPressed, {Color? color, Widget? child}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: child ?? Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  //Priority Color
  Color priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high': return Colors.red.shade300;
      case 'medium': return Colors.orange.shade300;
      case 'low': return Colors.green.shade300;
      default: return Colors.grey;
    }
  }
  //Status Color
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Colors.red;
      case 'in progress': return Colors.orange;
      case 'completed': return Colors.green;
      default: return Colors.grey;
    }
  }

}
