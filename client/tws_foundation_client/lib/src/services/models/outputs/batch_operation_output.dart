import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {model} class for [BatchOperationOutput].
///
/// Defines a data model class that represents an {output} object from a [FoundationServer] batch [EntityI] handling operation.
final class BatchOperationOutput<T extends EntityI<T>> implements EncodableI, DecodableI {
  /// Collection of batch operation successes.
  List<T> successes = <T>[];

  /// Collection of batch operation failures.
  List<EntityOperationFailure<T>> failures = <EntityOperationFailure<T>>[];

  /// Whether at least one operation iteration has failed.
  bool failed = false;

  /// Wheter all operations have failed.
  bool fullFailed = false;

  /// The total amount of operations executed.
  int operationsCount = 0;

  /// The total amount of failed operations.
  int failuresCount = 0;

  /// The total amount of successful operations.
  int successesCount = 0;

  ///
  final T Function() _entityBuilder;

  /// Creates a new [BatchOperationOutput] instance.
  BatchOperationOutput(this._entityBuilder);

  @override
  DataMap encode() {
    return <String, Object?>{
      'successes': successes.encode(),
      'failures': failures.encode(),
      'failed': failed,
      'fullFailed': fullFailed,
      'operationsCount': operationsCount,
      'failuresCount': failuresCount,
      'successesCount': successesCount,
    };
  }

  @override
  void decode(DataMap encode) {
    failed = encode.get('failed');
    fullFailed = encode.get('fullFailed');
    operationsCount = encode.get('operationsCount');
    failuresCount = encode.get('failuresCount');
    successesCount = encode.get('successesCount');

    final List<DataMap> successesDataMap = encode.get('successes');
    successes = successesDataMap.map(
      (Map<String, Object?> e) {
        final T entity = _entityBuilder();
        entity.decode(e);
        return entity;
      },
    ).toList();

    final List<DataMap> failuresDataMap = encode.get('failures');
    failures = failuresDataMap.map(
      (Map<String, Object?> e) {
        final EntityOperationFailure<T> entityOperationFailure = EntityOperationFailure<T>(_entityBuilder);
        entityOperationFailure.decode(e);
        return entityOperationFailure;
      },
    ).toList();
  }
}
