import '../../domain/entities/office_location.dart';
import '../../domain/repositories/office_location_repository.dart';
import '../datasources/local_office_location_datasource.dart';

class OfficeLocationRepositoryImpl implements OfficeLocationRepository {
  OfficeLocationRepositoryImpl(this._dataSource);

  final LocalOfficeLocationDataSource _dataSource;

  @override
  Future<void> setOfficeLocation(OfficeLocation location) async {
    await _dataSource.setOfficeLocation(location);
  }

  @override
  Future<OfficeLocation?> getOfficeLocation() async {
    return _dataSource.getOfficeLocation();
  }

  @override
  Future<void> setLastAttendanceAt(DateTime time) async {
    await _dataSource.setLastAttendanceAt(time);
  }

  @override
  Future<DateTime?> getLastAttendanceAt() async {
    return _dataSource.getLastAttendanceAt();
  }
}
