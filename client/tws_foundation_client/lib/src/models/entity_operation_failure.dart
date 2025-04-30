import 'package:csm_client/csm_client.dart';

/// [Class] stores data information about an [Entity] operation failure.
final class EntityOperationFailure<TEntity extends EntityB> implements DecodableI {
  /// [entity] property binding.
  static const String kEntity = 'entity';

  /// [message] property binding.
  static const String kMessage = 'message';

  /// [Entity] object instance where the operation failed.
  late TEntity entity;

  /// System failure message.
  String message = '';

  /// [entity] object factory.
  final TEntity Function() entityFactory;

  /// Creates a new [EntityOperationFailure] instance.
  EntityOperationFailure(this.entityFactory);

  @override
  void decode(JObject encode) {
    entity = entityFactory();
    entity.decode(encode[kEntity]);

    message = encode[kMessage];
  }
}
