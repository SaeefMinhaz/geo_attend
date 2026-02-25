import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geo_attend/features/attendance/data/datasources/local_office_location_datasource.dart';
import 'package:geo_attend/features/attendance/data/repositories/office_location_repository_impl.dart';
import 'package:geo_attend/features/attendance/data/services/location_service.dart';
import 'package:geo_attend/main.dart';

void main() {
  testWidgets('App loads and shows Attendance screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final dataSource = LocalOfficeLocationDataSource(prefs);
    final officeRepo = OfficeLocationRepositoryImpl(dataSource);
    final locationService = LocationService();

    await tester.pumpWidget(GeoAttendApp(
      officeRepository: officeRepo,
      locationService: locationService,
    ));
    await tester.pumpAndSettle();

    expect(find.text('Attendance'), findsOneWidget);
  });
}
