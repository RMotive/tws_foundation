import 'package:csm_client/csm_client.dart';

final class EntityUpdateOutput<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final TSet? previous;
  final TSet updated;

  const EntityUpdateOutput(this.previous, this.updated);

  factory EntityUpdateOutput.des(JObject json, TSet Function(JObject json) decoder) {
    JObject? rawPrevious = json.getDefault('previous', null);
    JObject rawUpdated = json.get('updated');

    TSet? previous = rawPrevious != null ? decoder(rawPrevious) : null;
    TSet updated = decoder(rawUpdated);

    return EntityUpdateOutput<TSet>(previous, updated);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'previous': previous?.encode(),
      'updated': updated.encode(),
    };
  }
}
