import 'package:flutter_test/flutter_test.dart';

import 'package:geo_attend/core/utils/geo_utils.dart';

void main() {
  group('distanceInMeters', () {
    test('is zero for identical points', () {
      final d = distanceInMeters(0, 0, 0, 0);
      expect(d, moreOrLessEquals(0, epsilon: 0.0001));
    });

    test('is about 111m for 0.001° longitude at equator', () {
      final d = distanceInMeters(0, 0, 0, 0.001);
      expect(d, moreOrLessEquals(111, epsilon: 5));
    });
  });
}
