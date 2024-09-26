import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

const String _kSuccesses = 'successes';
const String _kFailures = 'failures';
const String _kQTransactions = 'qTransactions';
const String _kQSuccesses = 'qSuccesses';
const String _kQFailures = 'qFailures';
const String _kFailed = 'failed';

final class SetBatchOut<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final List<TSet> successes;
  final List<SetOperationFailure<TSet>> failures;
  final int qTransactions;
  final int qSuccesses;
  final int qFailures;
  final bool failed;

  const SetBatchOut(this.successes, this.failures, this.qTransactions, this.qSuccesses, this.qFailures, this.failed);

  factory SetBatchOut.des(JObject json, TSet Function(JObject json) decoder) {
    List<JObject> decSuccesses = json.get(_kSuccesses);
    List<JObject> decFailures = json.get(_kFailures);

    final List<TSet> successes = decSuccesses.map<TSet>((JObject e) {
      TSet set = decoder(e);
      return set;
    }).toList();
    final List<SetOperationFailure<TSet>> failures = decFailures.map<SetOperationFailure<TSet>>(
      (JObject e) {
        SetOperationFailure<TSet> failure = SetOperationFailure<TSet>.des(e, decoder);
        return failure;
      },
    ).toList();

    final int qTransactions = json.get(_kQTransactions);
    final int qSuccesses = json.get(_kQSuccesses);
    final int qFailures = json.get(_kQFailures);
    final bool failed = json.get(_kFailed);

    return SetBatchOut<TSet>(successes, failures, qTransactions, qSuccesses, qFailures, failed);
  }

  @override
  JObject encode() {
    List<JObject> successesEncode = successes.map<JObject>((TSet e) => e.encode()).toList();
    List<JObject> failuresEncode = failures.map<JObject>((SetOperationFailure<TSet> e) => e.encode()).toList();

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
