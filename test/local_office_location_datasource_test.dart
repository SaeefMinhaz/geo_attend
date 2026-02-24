import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geo_attend/features/attendance/data/datasources/local_office_location_datasource.dart';
import 'package:geo_attend/features/attendance/domain/entities/office_location.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('LocalOfficeLocationDataSource saves and loads office location', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final dataSource = LocalOfficeLocationDataSource(prefs);

    final original = OfficeLocation(latitude: 10.0, longitude: 20.0);
    await dataSource.setOfficeLocation(original);
    final loaded = await dataSource.getOfficeLocation();

    expect(loaded, isNotNull);
    expect(loaded!.latitude, 10.0);
    expect(loaded.longitude, 20.0);
  });

  test('LocalOfficeLocationDataSource saves and loads last attendance time', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final dataSource = LocalOfficeLocationDataSource(prefs);

    final now = DateTime.now();
    await dataSource.setLastAttendanceAt(now);
    final loaded = await dataSource.getLastAttendanceAt();

    expect(loaded, isNotNull);
    // Compare up to seconds to avoid tiny timing differences.
    expect(loaded!.difference(now).inSeconds, 0);
  });
}
