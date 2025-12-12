import 'dart:typed_data';

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
/// {extension} for [Uint8List].
///
/// Provides extended members to simplify [Uint8List] type operations.
extension Uint8ListExtension on Uint8List {
  String get resolveImageExtension {
    if (length < 4) return 'invalid-extension';
    return (this[0] == 0xFF && this[1] == 0xD8)
        ? 'jpg'
        : (this[0] == 0x89 && this[1] == 0x50 && this[2] == 0x4E && this[3] == 0x47)
        ? 'png'
        : (this[0] == 0x52 && this[1] == 0x49 && this[2] == 0x46 && this[3] == 0x46)
        ? 'webp'
        : (this[0] == 0x47 && this[1] == 0x49 && this[2] == 0x46)
        ? 'gif'
        : (this[0] == 0x42 && this[1] == 0x4D)
        ? 'bmp'
        : 'not-supported-extension';
  }
}
