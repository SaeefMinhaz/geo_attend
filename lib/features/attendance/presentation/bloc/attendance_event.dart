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
