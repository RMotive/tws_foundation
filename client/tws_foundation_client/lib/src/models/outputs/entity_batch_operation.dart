import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/models/entity_operation_failure.dart';

const String _kSuccesses = 'successes';
const String _kFailures = 'failures';
const String _kQTransactions = 'qTransactions';
const String _kQSuccesses = 'qSuccesses';
const String _kQFailures = 'qFailures';
const String _kFailed = 'failed';

final class EntityBatchOperation<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final List<TSet> successes;
  final List<EntityOperationFailure<TSet>> failures;
  final int qTransactions;
  final int qSuccesses;
  final int qFailures;
  final bool failed;

  const EntityBatchOperation(this.successes, this.failures, this.qTransactions, this.qSuccesses, this.qFailures, this.failed);

  factory EntityBatchOperation.des(JObject json, TSet Function(JObject json) decoder) {
    List<JObject> decSuccesses = json.get(_kSuccesses);
    List<JObject> decFailures = json.get(_kFailures);

    final List<TSet> successes = decSuccesses.map<TSet>((JObject e) {
      TSet set = decoder(e);
      return set;
    }).toList();
    final List<EntityOperationFailure<TSet>> failures = decFailures.map<EntityOperationFailure<TSet>>(
      (JObject e) {
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
  JObject encode() {
    List<JObject> successesEncode = successes.map<JObject>((TSet e) => e.encode()).toList();
    List<JObject> failuresEncode = failures.map<JObject>((EntityOperationFailure<TSet> e) => e.encode()).toList();

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
