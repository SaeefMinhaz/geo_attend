import 'package:equatable/equatable.dart';

import '../../domain/entities/office_location.dart';

class AttendanceState extends Equatable {
  const AttendanceState({
    this.savedOffice,
    this.isLoading = false,
    this.errorMessage,
  });

  final OfficeLocation? savedOffice;
  final bool isLoading;
  final String? errorMessage;

  AttendanceState copyWith({
    OfficeLocation? savedOffice,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AttendanceState(
      savedOffice: savedOffice ?? this.savedOffice,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [savedOffice, isLoading, errorMessage];
}
