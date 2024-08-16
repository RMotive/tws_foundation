import 'package:csm_foundation_services/csm_foundation_services.dart';

final class MigrationUpdateResult<TSet extends CSMSetInterface> implements CSMEncodeInterface {
  final TSet? previous;
  final TSet updated;

  const MigrationUpdateResult(this.previous, this.updated);

  factory MigrationUpdateResult.des(JObject json, {CSMDecodeInterface<TSet>? decoder}) {
    JObject? rawPrevious = json.getDefault('previous', null);
    JObject rawUpdated = json.get('updated');

    TSet? previous = rawPrevious != null ? deserealize(rawPrevious, decode: decoder) : null;
    TSet updated = deserealize(rawUpdated, decode: decoder);

    return MigrationUpdateResult<TSet>(previous, updated);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'previous': previous?.encode(),
      'updated': updated.encode(),
    };
  }
}

final class MigrationUpdateResultDecoder<TSet extends CSMSetInterface> implements CSMDecodeInterface<MigrationUpdateResult<TSet>> {
  final CSMDecodeInterface<TSet> innerDecoder;

  const MigrationUpdateResultDecoder(this.innerDecoder);

  @override
  MigrationUpdateResult<TSet> decode(JObject json) {
    return MigrationUpdateResult<TSet>.des(json, decoder: innerDecoder);
  }
}
