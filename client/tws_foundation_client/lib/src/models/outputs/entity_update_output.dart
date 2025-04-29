import 'package:csm_client/csm_client.dart';

final class EntityUpdateOutput<TSet extends EntityB<TSet>> implements EncodableI {
  final TSet? previous;
  final TSet updated;

  const EntityUpdateOutput(this.previous, this.updated);

  factory EntityUpdateOutput.des(DataMap json, TSet Function(DataMap json) decoder) {
    DataMap? rawPrevious = json.get('previous', null);
    DataMap rawUpdated = json.get('updated');

    TSet? previous = rawPrevious != null ? decoder(rawPrevious) : null;
    TSet updated = decoder(rawUpdated);

    return EntityUpdateOutput<TSet>(previous, updated);
  }

  @override
  DataMap encode() {
    return <String, dynamic>{
      'previous': previous?.encode(),
      'updated': updated.encode(),
    };
  }
}
