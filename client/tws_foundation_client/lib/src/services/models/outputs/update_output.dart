import 'package:csm_client/csm_client.dart';

/// {model} class for [UpdateOutput].
///
/// Defines a data model class that represents an {Output} object for an {Update} operation, storing
/// the result interest data from an {Update} operation.
final class UpdateOutput<T extends EntityI<T>> implements DecodableI, EncodableI {
  /// The new updated [T] instance object.
  late T updated;

  /// The original [T] instance, before the update operation. This property depends on the operation parameters and if there
  /// was an original [T] instance before the update operation with the same [EntityI.id] value.
  T? original;

  /// [decode] purposes [T] builder.
  final T Function() _entityBuilder;

  /// Creates a new [UpdateOutput] instance.
  UpdateOutput(this._entityBuilder) {
    updated = _entityBuilder();
  }

  @override
  void decode(DataMap encode) {
    final DataMap updatedData = encode.get('updated');
    updated = _entityBuilder();
    updated.decode(updatedData);

    final DataMap? originalData = encode.get('original', null);
    original = originalData == null ? null : _entityBuilder();
    original?.decode(originalData ?? <String, Object?>{});
  }

  @override
  DataMap encode() {
    return <String, Object?>{
      'updated': updated.encode(),
      'original': original?.encode(),
    };
  }
}
