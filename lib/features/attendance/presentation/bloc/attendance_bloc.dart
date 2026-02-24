import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/location_service.dart';
import '../../domain/repositories/office_location_repository.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({
    required OfficeLocationRepository officeRepository,
    required LocationService locationService,
  })  : _officeRepository = officeRepository,
        _locationService = locationService,
        super(const AttendanceState()) {
    on<LoadSavedOffice>(_onLoadSavedOffice);
    on<SetOfficeLocationRequested>(_onSetOfficeLocationRequested);
  }

  final OfficeLocationRepository _officeRepository;
  final LocationService _locationService;

  Future<void> _onLoadSavedOffice(
    LoadSavedOffice event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(errorMessage: null));
    final office = await _officeRepository.getOfficeLocation();
    emit(state.copyWith(savedOffice: office));
  }

  Future<void> _onSetOfficeLocationRequested(
    SetOfficeLocationRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final position = await _locationService.getCurrentPosition();
      await _officeRepository.setOfficeLocation(position);
      emit(state.copyWith(
        savedOffice: position,
        isLoading: false,
        errorMessage: null,
      ));
    } on LocationServiceException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      ));
    }
  }
}
