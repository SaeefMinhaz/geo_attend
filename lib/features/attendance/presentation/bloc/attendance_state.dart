import 'package:equatable/equatable.dart';

import '../../domain/entities/office_location.dart';

class AttendanceState extends Equatable {
  const AttendanceState({
    this.savedOffice,
    this.isLoading = false,
    this.errorMessage,
    this.distanceMeters,
    this.distanceError,
  });

  final OfficeLocation? savedOffice;
  final bool isLoading;
  final String? errorMessage;
  final double? distanceMeters;
  final String? distanceError;

  AttendanceState copyWith({
    OfficeLocation? savedOffice,
    bool? isLoading,
    String? errorMessage,
    double? distanceMeters,
    String? distanceError,
  }) {
    return AttendanceState(
      savedOffice: savedOffice ?? this.savedOffice,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      distanceError: distanceError,
    );
  }

  @override
  List<Object?> get props =>
      [savedOffice, isLoading, errorMessage, distanceMeters, distanceError];
}
