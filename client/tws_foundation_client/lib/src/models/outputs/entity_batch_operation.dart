import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/entity_operation_failure.dart';

const String _kSuccesses = 'successes';
const String _kFailures = 'failures';
const String _kQTransactions = 'qTransactions';
const String _kQSuccesses = 'qSuccesses';
const String _kQFailures = 'qFailures';
const String _kFailed = 'failed';

final class EntityBatchOperation<TSet extends EntityB<TSet>> implements EncodableI, DecodableI {
  List<TSet> successes;
  List<EntityOperationFailure<TSet>> failures;
  int qTransactions;
  int qSuccesses;
  int qFailures;
  bool failed;
  /// Internal [T] builder for [DecodableI] purposes.
  final TSet Function() _entityBuilder;

  EntityBatchOperation(this.successes, this.failures, this.qTransactions, this.qSuccesses, this.qFailures, this.failed, this._entityBuilder);

  @override
  DataMap encode() {
    List<DataMap> successesEncode = successes.map<DataMap>((TSet e) => e.encode()).toList();
    List<DataMap> failuresEncode = failures.map<DataMap>((EntityOperationFailure<TSet> e) => e.encode()).toList();

    return <String, dynamic>{
      _kSuccesses: successesEncode,
      _kFailures: failuresEncode,
      _kQTransactions: qTransactions,
      _kQSuccesses: qSuccesses,
      _kQFailures: qFailures,
      _kFailed: failed,
    };
  }
  
  @override
  void decode(DataMap encode) {
    qTransactions = encode.get(_kQTransactions);
    qSuccesses = encode.get(_kQSuccesses);
    qFailures = encode.get(_kQFailures);
    failed = encode.get(_kFailed);

    List<DataMap> decSuccesses = encode.get(_kSuccesses);
    List<DataMap> decFailures = encode.get(_kFailures);

    successes = decSuccesses.map<TSet>((DataMap e) {
      TSet set = _entityBuilder();
      set.decode(e);
      return set;
    }).toList();

    failures = decFailures.map<EntityOperationFailure<TSet>>(
      (DataMap e) {        
        EntityOperationFailure<TSet> failure = EntityOperationFailure<TSet>(_entityBuilder);
        failure.decode(e);
        return failure;
      },
    ).toList();
  }
}
