import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants.dart';
import '../../domain/entities/office_location.dart';

/// Saves and loads office coordinates using SharedPreferences.
class LocalOfficeLocationDataSource {
  LocalOfficeLocationDataSource(this._prefs);

  final SharedPreferences _prefs;

  Future<void> setOfficeLocation(OfficeLocation location) async {
    await _prefs.setDouble(AttendanceConstants.keyOfficeLat, location.latitude);
    await _prefs.setDouble(AttendanceConstants.keyOfficeLng, location.longitude);
  }

  Future<OfficeLocation?> getOfficeLocation() async {
    final lat = _prefs.getDouble(AttendanceConstants.keyOfficeLat);
    final lng = _prefs.getDouble(AttendanceConstants.keyOfficeLng);
    if (lat == null || lng == null) return null;
    return OfficeLocation(latitude: lat, longitude: lng);
  }
}
