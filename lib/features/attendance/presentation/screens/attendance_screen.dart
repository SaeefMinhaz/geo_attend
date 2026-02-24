import 'package:flutter/material.dart';

/// Main screen for setting office location and marking attendance.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Set office location, then mark attendance when you\'re nearby.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Placeholder for "Set Office Location" button
            const SizedBox(height: 16),
            // Placeholder for "Mark Attendance" button
          ],
        ),
      ),
    );
  }
}
