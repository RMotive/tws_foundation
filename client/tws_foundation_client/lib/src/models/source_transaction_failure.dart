import 'package:csm_foundation_services/csm_foundation_services.dart';

const String _kSet = 'set';
const String _kSystem = 'system';

final class MigrationTransactionFailure<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final TSet set;
  final String system;

  const MigrationTransactionFailure(this.set, this.system);
  factory MigrationTransactionFailure.des(
    JObject json, {
    CSMDecodeInterface<TSet>? setDecoder,
  }) {
    JObject decSet = json.get(_kSet);
    TSet set = deserealize(decSet, decode: setDecoder);

    String system = json.get(_kSystem);

    return MigrationTransactionFailure<TSet>(set, system);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      _kSet: set.encode(),
      _kSystem: system,
    };
  }
}

final class MigrationTransactionFailureDecoder<TSet extends CSMSetInterface> implements CSMDecodeInterface<MigrationTransactionFailure<TSet>> {
  final CSMDecodeInterface<TSet> setDecoder;

  const MigrationTransactionFailureDecoder(this.setDecoder);

  @override
  MigrationTransactionFailure<TSet> decode(JObject json) {
    return MigrationTransactionFailure<TSet>.des(json, setDecoder: setDecoder);
  }
}
