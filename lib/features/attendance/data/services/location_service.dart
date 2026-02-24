import 'package:geolocator/geolocator.dart';

import '../../domain/entities/office_location.dart';

/// Wraps geolocator: permissions and current position.
/// Throws [LocationServiceException] so the BLoC can show user-friendly messages.
class LocationService {
  Future<bool> get hasPermission async {
    return await Geolocator.isLocationServiceEnabled() &&
        await _checkPermission();
  }

  Future<bool> _checkPermission() async {
    var status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }
    return status == LocationPermission.whileInUse ||
        status == LocationPermission.always;
  }

  /// Returns current position as [OfficeLocation].
  /// Throws [LocationServiceException] on permission or hardware failure.
  Future<OfficeLocation> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException(
        'Please turn on location services in your device settings.',
      );
    }

    final permitted = await _checkPermission();
    if (!permitted) {
      throw LocationServiceException(
        'Location permission is required to set office and mark attendance. You can enable it in settings.',
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return OfficeLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      if (e is LocationServiceException) rethrow;
      final isDenied = e.toString().toLowerCase().contains('denied') ||
          e.toString().toLowerCase().contains('permission');
      throw LocationServiceException(
        isDenied
            ? 'Location permission was denied.'
            : 'Could not get location. Try again in an open area with a clear view of the sky.',
      );
    }
  }

  /// Stream of position updates for real-time distance. Check permission before using.
  Stream<Position> get positionStream => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          distanceFilter: 10,
        ),
      );
}

class LocationServiceException implements Exception {
  LocationServiceException(this.message);
  final String message;
}
