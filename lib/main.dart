import 'package:flutter/material.dart';

import 'features/attendance/presentation/screens/attendance_screen.dart';

void main() {
  runApp(const GeoAttendApp());
}

class GeoAttendApp extends StatelessWidget {
  const GeoAttendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Attend',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AttendanceScreen(),
    );
  }
}
