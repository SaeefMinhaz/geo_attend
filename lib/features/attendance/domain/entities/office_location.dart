/// Saved office coordinates used as the geo-fence center.
class OfficeLocation {
  OfficeLocation({
    required this.latitude,
    required this.longitude,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();

  final double latitude;
  final double longitude;
  final DateTime savedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficeLocation &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);
}
