import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/attendance/data/datasources/local_office_location_datasource.dart';
import 'features/attendance/data/repositories/office_location_repository_impl.dart';
import 'features/attendance/domain/repositories/office_location_repository.dart';
import 'features/attendance/presentation/screens/attendance_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dataSource = LocalOfficeLocationDataSource(prefs);
  final officeRepo = OfficeLocationRepositoryImpl(dataSource);
  runApp(GeoAttendApp(officeRepository: officeRepo));
}

class GeoAttendApp extends StatelessWidget {
  const GeoAttendApp({super.key, required this.officeRepository});

  final OfficeLocationRepository officeRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Attend',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AttendanceScreen(),
    );
  }
}
