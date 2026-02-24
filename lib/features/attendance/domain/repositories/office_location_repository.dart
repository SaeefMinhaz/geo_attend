import '../entities/office_location.dart';

/// Persists and retrieves the user's saved office location.
abstract class OfficeLocationRepository {
  Future<void> setOfficeLocation(OfficeLocation location);

  Future<OfficeLocation?> getOfficeLocation();
}
