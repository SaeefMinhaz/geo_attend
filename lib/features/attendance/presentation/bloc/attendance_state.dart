import 'package:equatable/equatable.dart';

import '../../../../core/constants.dart';
import '../../domain/entities/office_location.dart';

class AttendanceState extends Equatable {
  const AttendanceState({
    this.savedOffice,
    this.isLoading = false,
    this.errorMessage,
    this.distanceMeters,
    this.distanceError,
    this.attendanceMarkedAt,
  });

  final OfficeLocation? savedOffice;
  final bool isLoading;
  final String? errorMessage;
  final double? distanceMeters;
  final String? distanceError;
  final DateTime? attendanceMarkedAt;

  bool get canMarkAttendance =>
      distanceMeters != null &&
      distanceMeters! <= AttendanceConstants.attendanceRadiusMeters;

  AttendanceState copyWith({
    OfficeLocation? savedOffice,
    bool? isLoading,
    String? errorMessage,
    double? distanceMeters,
    String? distanceError,
    DateTime? attendanceMarkedAt,
  }) {
    return AttendanceState(
      savedOffice: savedOffice ?? this.savedOffice,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      distanceError: distanceError,
      attendanceMarkedAt: attendanceMarkedAt ?? this.attendanceMarkedAt,
    );
  }

  @override
  List<Object?> get props => [
        savedOffice,
        isLoading,
        errorMessage,
        distanceMeters,
        distanceError,
        attendanceMarkedAt,
      ];
}
