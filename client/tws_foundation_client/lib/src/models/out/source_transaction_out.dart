import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

const String _kSuccesses = 'successes';
const String _kFailures = 'failures';
const String _kQTransactions = 'qTransactions';
const String _kQSuccesses = 'qSuccesses';
const String _kQFailures = 'qFailures';
const String _kFailed = 'failed';

final class MigrationTransactionResult<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final List<TSet> successes;
  final List<MigrationTransactionFailure<TSet>> failures;
  final int qTransactions;
  final int qSuccesses;
  final int qFailures;
  final bool failed;

  const MigrationTransactionResult(this.successes, this.failures, this.qTransactions, this.qSuccesses, this.qFailures, this.failed);

  factory MigrationTransactionResult.des(
    JObject json, {
    CSMDecodeInterface<TSet>? setDecoder,
  }) {
    List<JObject> decSuccesses = json.get(_kSuccesses);
    List<JObject> decFailures = json.get(_kFailures);

    final List<TSet> successes = decSuccesses.map<TSet>((JObject e) {
      TSet set = deserealize(e, decode: setDecoder);
      return set;
    }).toList();
    final List<MigrationTransactionFailure<TSet>> failures = decFailures.map<MigrationTransactionFailure<TSet>>(
      (JObject e) {
        CSMDecodeInterface<MigrationTransactionFailure<TSet>>? decoder;
        if (setDecoder != null) {
          decoder = MigrationTransactionFailureDecoder<TSet>(setDecoder);
        }

        MigrationTransactionFailure<TSet> failure = deserealize(e, decode: decoder);
        return failure;
      },
    ).toList();

    final int qTransactions = json.get(_kQTransactions);
    final int qSuccesses = json.get(_kQSuccesses);
    final int qFailures = json.get(_kQFailures);
    final bool failed = json.get(_kFailed);

    return MigrationTransactionResult<TSet>(successes, failures, qTransactions, qSuccesses, qFailures, failed);
  }

  @override
  JObject encode() {
    List<JObject> successesEncode = successes.map<JObject>((TSet e) => e.encode()).toList();
    List<JObject> failuresEncode = failures.map<JObject>((MigrationTransactionFailure<TSet> e) => e.encode()).toList();

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

final class MigrationTransactionResultDecoder<TSet extends CSMSetInterface> implements CSMDecodeInterface<MigrationTransactionResult<TSet>> {
  final CSMDecodeInterface<TSet> setDecoder;

  const MigrationTransactionResultDecoder(this.setDecoder);

  @override
  MigrationTransactionResult<TSet> decode(JObject json) {
    return MigrationTransactionResult<TSet>.des(json, setDecoder: setDecoder);
  }
}
