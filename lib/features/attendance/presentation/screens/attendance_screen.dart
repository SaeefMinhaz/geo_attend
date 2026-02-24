import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

String _formatDateTime(DateTime dt) {
  return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

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
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        buildWhen: (prev, curr) =>
            prev.savedOffice != curr.savedOffice ||
            prev.isLoading != curr.isLoading ||
            prev.distanceMeters != curr.distanceMeters ||
            prev.distanceError != curr.distanceError ||
            prev.attendanceMarkedAt != curr.attendanceMarkedAt ||
            prev.canMarkAttendance != curr.canMarkAttendance,
        builder: (context, state) {
          String distanceText;
          if (state.savedOffice == null) {
            distanceText = 'Set office location first.';
          } else if (state.distanceError != null) {
            distanceText = state.distanceError!;
          } else if (state.distanceMeters != null) {
            final m = state.distanceMeters!.round();
            distanceText = 'You are ${m}m away from the office.';
          } else {
            distanceText = 'Getting your distance…';
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Set your office location, then mark attendance when you\'re nearby.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  distanceText,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (state.savedOffice != null)
                  Text(
                    'Office at ${state.savedOffice!.latitude.toStringAsFixed(5)}, ${state.savedOffice!.longitude.toStringAsFixed(5)}',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    'Office not set.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: state.isLoading
                      ? null
                      : () => context.read<AttendanceBloc>().add(
                            const SetOfficeLocationRequested(),
                          ),
                  icon: state.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.location_on),
                  label: Text(
                    state.isLoading
                        ? 'Getting location…'
                        : 'Set Office Location',
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: state.canMarkAttendance
                      ? () => context.read<AttendanceBloc>().add(
                            const MarkAttendanceRequested(),
                          )
                      : null,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Mark Attendance'),
                ),
                if (!state.canMarkAttendance && state.savedOffice != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Move within 50 m of the office to enable.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
                if (state.attendanceMarkedAt != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Last marked: ${_formatDateTime(state.attendanceMarkedAt!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
