import '../entities/office_location.dart';

/// Persists and retrieves the user's saved office location and last attendance.
abstract class OfficeLocationRepository {
  Future<void> setOfficeLocation(OfficeLocation location);

  Future<OfficeLocation?> getOfficeLocation();

  Future<void> setLastAttendanceAt(DateTime time);

  Future<DateTime?> getLastAttendanceAt();
}
