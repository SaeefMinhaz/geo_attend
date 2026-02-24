import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/geo_utils.dart';
import '../../data/services/location_service.dart';
import '../../domain/entities/office_location.dart';
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
    on<MarkAttendanceRequested>(_onMarkAttendanceRequested);
  }

  final OfficeLocationRepository _officeRepository;
  final LocationService _locationService;
  StreamSubscription<Position>? _distanceSubscription;

  @override
  Future<void> close() {
    _distanceSubscription?.cancel();
    return super.close();
  }

  void _startDistanceUpdates(
    Emitter<AttendanceState> emit,
    OfficeLocation office,
  ) {
    _distanceSubscription?.cancel();
    _distanceSubscription = _locationService.positionStream.listen(
      (position) {
        final meters = distanceInMeters(
          office.latitude,
          office.longitude,
          position.latitude,
          position.longitude,
        );
        emit(state.copyWith(
          distanceMeters: meters,
          distanceError: null,
        ));
      },
      onError: (_) {
        emit(state.copyWith(
          distanceError: 'Distance unavailable. Check that location is on.',
          distanceMeters: null,
        ));
      },
    );
  }

  Future<void> _onLoadSavedOffice(
    LoadSavedOffice event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(errorMessage: null));
    final office = await _officeRepository.getOfficeLocation();
    final lastAttendance = await _officeRepository.getLastAttendanceAt();
    emit(state.copyWith(
      savedOffice: office,
      attendanceMarkedAt: lastAttendance,
    ));
    if (office != null) _startDistanceUpdates(emit, office);
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
      _startDistanceUpdates(emit, position);
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

  Future<void> _onMarkAttendanceRequested(
    MarkAttendanceRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    if (!state.canMarkAttendance) return;
    final now = DateTime.now();
    await _officeRepository.setLastAttendanceAt(now);
    emit(state.copyWith(attendanceMarkedAt: now));
  }
}
