import 'package:csm_client/csm_client.dart';

const String _kSet = 'set';
const String _kSystem = 'system';

///
final class EntityOperationFailure<TSet extends EntityB<TSet>> implements EncodableI {
  ///
  final TSet set;

  ///
  final String system;

  ///
  const EntityOperationFailure(this.set, this.system);

  ///
  factory EntityOperationFailure.des(DataMap json, TSet Function(DataMap json) decoder) {
    DataMap decSet = json.get(_kSet);
    TSet set = decoder(decSet);

    String system = json.get(_kSystem);

    return EntityOperationFailure<TSet>(set, system);
  }

  @override
  DataMap encode() {
    return <String, dynamic>{
      _kSet: set.encode(),
      _kSystem: system,
    };
  }
}
