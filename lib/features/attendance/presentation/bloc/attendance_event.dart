import 'package:equatable/equatable.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

/// Load saved office from storage on startup.
final class LoadSavedOffice extends AttendanceEvent {
  const LoadSavedOffice();
}

/// User tapped "Set Office Location" — fetch GPS and save.
final class SetOfficeLocationRequested extends AttendanceEvent {
  const SetOfficeLocationRequested();
}

/// User tapped "Mark Attendance" (only valid when within 50 m).
final class MarkAttendanceRequested extends AttendanceEvent {
  const MarkAttendanceRequested();
}

/// Distance from current position to office changed.
final class DistanceChanged extends AttendanceEvent {
  const DistanceChanged(this.meters);

  final double meters;

  @override
  List<Object?> get props => [meters];
}

/// Failed to update distance (e.g. location off or stream error).
final class DistanceError extends AttendanceEvent {
  const DistanceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
