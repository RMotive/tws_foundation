import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/entity_operation_failure.dart';

const String _kSuccesses = 'successes';
const String _kFailures = 'failures';
const String _kQTransactions = 'qTransactions';
const String _kQSuccesses = 'qSuccesses';
const String _kQFailures = 'qFailures';
const String _kFailed = 'failed';

final class EntityBatchOperation<TSet extends EntityB<TSet>> implements EncodableI {
  final List<TSet> successes;
  final List<EntityOperationFailure<TSet>> failures;
  final int qTransactions;
  final int qSuccesses;
  final int qFailures;
  final bool failed;

  const EntityBatchOperation(this.successes, this.failures, this.qTransactions, this.qSuccesses, this.qFailures, this.failed);

  factory EntityBatchOperation.des(
      DataMap json, TSet Function(DataMap json) decoder) {
    List<DataMap> decSuccesses = json.get(_kSuccesses);
    List<DataMap> decFailures = json.get(_kFailures);

    final List<TSet> successes = decSuccesses.map<TSet>((DataMap e) {
      TSet set = decoder(e);
      return set;
    }).toList();
    final List<EntityOperationFailure<TSet>> failures = decFailures.map<EntityOperationFailure<TSet>>(
      (DataMap e) {
        EntityOperationFailure<TSet> failure = EntityOperationFailure<TSet>.des(e, decoder);
        return failure;
      },
    ).toList();

    final int qTransactions = json.get(_kQTransactions);
    final int qSuccesses = json.get(_kQSuccesses);
    final int qFailures = json.get(_kQFailures);
    final bool failed = json.get(_kFailed);

    return EntityBatchOperation<TSet>(successes, failures, qTransactions, qSuccesses, qFailures, failed);
  }

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
}
