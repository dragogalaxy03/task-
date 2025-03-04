
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Map<String, dynamic>> reportData = [
    {
      'title': 'Task 1',
      'date': '03-03-25',
      'user': 'Abhishek',
      'location': 'New York',
      'status': 'Pending',
      'expanded': false,
      'subTasks': [
        {'date': '03-01-25', 'status': 'Completed'},
        {'date': '02-03-25', 'status': 'In Progress'},
        {'date': '02-03-25', 'status': 'Completed'},
      ]
    },
    {
      'title': 'Task 2',
      'date': '03-01-25',
      'user': 'Rahul',
      'location': 'Chicago',
      'status': 'Completed',
      'expanded': false,
      'subTasks': [
        {'date': '03-02-25', 'status': 'Pending'},
      ]
    },
    {
      'title': 'Task 3',
      'date': '03-01-25',
      'user': 'Rahul',
      'location': 'Chicago',
      'status': 'Completed',
      'expanded': false,
      'subTasks': [
        {'date': '03-02-25', 'status': 'Pending'},
      ]
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Screen',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)], // Dark Grey Gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200, // Light Grey Background
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: reportData.length,
        itemBuilder: (context, index) => buildReportCard(reportData[index], index),
      ),
    );
  }

  Widget buildReportCard(Map<String, dynamic> task, int index) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Expand Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          task['expanded'] = !task['expanded'];
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade600,
                        radius: 16,
                        child: Icon(
                          task['expanded'] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                /// User & Location (Ensure it stays outside the dropdown)
                Row(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.black),
                    const SizedBox(width: 6),
                    Text(
                      task['user'],
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 18, color: Colors.black),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        task['location'],
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, height: 18),

                /// Date & Status Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      _buildRow(Icons.calendar_today, 'Date', task['date'], Icons.check_circle, 'Status', task['status']),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Expanded Subtasks with Animation (Location is NOT here)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: task['expanded'] ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: List.generate(
                  task['subTasks'].length,
                      (subIndex) => buildSubTaskCard(task['subTasks'][subIndex], subIndex),
                ),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }



  Widget buildSubTaskCard(Map<String, dynamic> subTask, int subIndex) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: subIndex.isEven ? Colors.grey.shade300 : Colors.grey.shade100,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(Icons.calendar_today, 'Date', subTask['date'], Icons.check_circle, 'Status', subTask['status']),
          ],
        ),
      ),
    );
  }


  Widget _buildRow(IconData? icon1, String label1, String value1, IconData? icon2, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (icon1 != null) Icon(icon1, size: 18, color: Colors.black),
          if (icon1 != null) const SizedBox(width: 6),
          Expanded(
            child: Text(
              '$label1: $value1',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          if (label2.isNotEmpty) const SizedBox(width: 12),
          if (label2.isNotEmpty && icon2 != null) Icon(icon2, size: 18, color: Colors.black),
          if (label2.isNotEmpty && icon2 != null) const SizedBox(width: 6),
          if (label2.isNotEmpty)
            Expanded(
              child: Text(
                '$label2: $value2',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: _getStatusColor(value2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Function to color-code status text
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      default:
        return Colors.black87;
    }
  }
}