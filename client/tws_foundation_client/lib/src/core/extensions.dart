import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
extension ViewFilterNodesCollection<T extends EntityI<T>> on List<ViewFilterNodeI<T>> {
  ///
  List<DataMap> encode() {
    return map(
      (ViewFilterNodeI<T> el) => el.encode(),
    ).toList();
  }
}

///
extension ViewOrderingCollection on List<ViewOrdering> {
  ///
  List<DataMap> encode() {
    return map(
      (ViewOrdering el) => el.encode(),
    ).toList();
  }
}

///
extension EntityCollection<T extends EntityI<T>> on List<T> {
  ///
  List<DataMap> encode() {
    return map((T el) => el.encode()).toList();
  }
}

///
extension EntityOperationFailureCollection<T extends EntityI<T>> on List<EntityOperationFailure<T>> {
  ///
  List<DataMap> encode() {
    return map(
      (EntityOperationFailure<T> e) => e.encode(),
    ).toList();
  }
}

/// Cleaning extension for string properties.
extension StringSanitizer on String? {
  /// Flag to define if current string need to be sanitized.
  bool get dirtyString => (this != null && this!.trim().isEmpty);

  /// Check if the current string is not empty. 
  /// Return null string when the content is invalid.
  String? get cleaned => dirtyString ? null : this;

  /// Try to sanitize the current string.
  /// If sanitized is not needed, then try to return the current string or [fallback] property if is valid.
  String? sanitizeOrFallback(String? fallback) =>
      dirtyString ? null : this ?? fallback;
}

/// Date formating extension for string properties.
extension StringDateFormating on DateTime {
  /// Get the ISO 8601 string with date only string.
  String get dateOnlyIso => toIso8601String().split('T').first;
}

