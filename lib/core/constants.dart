/// App-wide constants for the attendance feature.
class AttendanceConstants {
  AttendanceConstants._();

  /// Maximum distance (meters) from office to allow marking attendance.
  static const double attendanceRadiusMeters = 50.0;

  /// SharedPreferences key for office latitude.
  static const String keyOfficeLat = 'office_lat';

  /// SharedPreferences key for office longitude.
  static const String keyOfficeLng = 'office_lng';

  /// SharedPreferences key for last attendance timestamp.
  static const String keyLastAttendanceAt = 'last_attendance_at';
}
