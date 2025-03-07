import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:taskcard/Beat%20Planning/beat-planning-screen.dart';
import 'package:taskcard/Bottomsheet/bottomsheet_view.dart';
import 'package:taskcard/Report/report-screen.dart';
import 'package:taskcard/Stock%20Update%20Screen/stock_update.dart';
import 'package:taskcard/Task/task-list.dart';
import 'Common Tab/common_tab.dart';
import 'Task/task-card.dart';
import 'Task/task-model.dart'; // Ensure correct import path

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Set to false for production
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BeatPlanningScreen(),
      builder: DevicePreview.appBuilder, // Add this for preview support
      locale: DevicePreview.locale(context), // Sync locale with preview
    );
  }
}

