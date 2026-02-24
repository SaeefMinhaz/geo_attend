import 'package:flutter_test/flutter_test.dart';

import 'package:geo_attend/core/constants.dart';
import 'package:geo_attend/features/attendance/presentation/bloc/attendance_state.dart';

void main() {
  group('AttendanceState.canMarkAttendance', () {
    test('is false when distance is null', () {
      const state = AttendanceState();
      expect(state.canMarkAttendance, isFalse);
    });

    test('is true when distance is within radius', () {
      const state = AttendanceState(
        distanceMeters: AttendanceConstants.attendanceRadiusMeters - 1,
      );
      expect(state.canMarkAttendance, isTrue);
    });

    test('is false when distance is greater than radius', () {
      const state = AttendanceState(
        distanceMeters: AttendanceConstants.attendanceRadiusMeters + 1,
      );
      expect(state.canMarkAttendance, isFalse);
    });
  });
}
