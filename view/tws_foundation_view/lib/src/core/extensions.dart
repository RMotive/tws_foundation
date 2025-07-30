/// {extension} for [DateTime].
///
/// Provides extended members to simplify [DateTime] type operations.
extension DateTimeExtension on DateTime {
  /// [dateOnly] set a 'DateOnly' format.
  String get dateOnly =>
      "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

  /// [fullDate] get only date and time format.
  String get fullDate =>
      "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}
