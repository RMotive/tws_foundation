import 'package:csm_client/csm_client.dart';

const String _kSet = 'set';
const String _kSystem = 'system';

final class SetOperationFailure<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final TSet set;
  final String system;

  const SetOperationFailure(this.set, this.system);

  factory SetOperationFailure.des(JObject json, TSet Function(JObject json) decoder) {
    JObject decSet = json.get(_kSet);
    TSet set = decoder(decSet);

    String system = json.get(_kSystem);

    return SetOperationFailure<TSet>(set, system);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      _kSet: set.encode(),
      _kSystem: system,
    };
  }
}
