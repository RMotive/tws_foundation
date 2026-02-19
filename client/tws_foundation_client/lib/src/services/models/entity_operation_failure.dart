import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {implementation} class for a [EntityOperationFailure].
///
/// Defines an object that stores information about an [IEntity] operation failure result at a [FoundationServer] service request.
final class EntityOperationFailure<T extends IEntity<T>> implements IDecodable, IEncodable {
  /// Key binding for [entity] property..
  static const String kEntity = 'entity';

  /// Key binding for [message] property.
  static const String kMessage = 'message';

  /// Original instance that the operation was committed and failed..
  late T entity;

  /// Message caugth from the immediate exception that caused the operation failure.
  String message = '';

  /// Object factory for [T] types.
  final T Function() entityFactory;

  /// Creates a new [EntityOperationFailure] instance.
  EntityOperationFailure(this.entityFactory);

  @override
  void decode(DataMap encode) {
    message = encode.get(kMessage);

    entity = entityFactory();
    entity.decode(encode.get(kEntity));
  }

  @override
  DataMap encode() {
    return <String, Object?>{
      'entity': entity.encode(),
      'message': message,
    };
  }
}
