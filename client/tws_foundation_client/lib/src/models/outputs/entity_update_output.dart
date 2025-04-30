import 'package:csm_client/csm_client.dart';

final class EntityUpdateOutput<TSet extends EntityB<TSet>> implements EncodableI, DecodableI {
  TSet? previous;
  TSet updated;

  /// Creates a new [EntityUpdateOutput] instance.
  EntityUpdateOutput(this.previous, this.updated, this._entityBuilder);

   /// Internal [T] builder for [DecodableI] purposes.
  final TSet Function() _entityBuilder;

  @override
  DataMap encode() {
    return <String, dynamic>{
      'previous': previous?.encode(),
      'updated': updated.encode(),
    };
  }
  
  @override
  void decode(DataMap encode) {
    DataMap rawUpdated = encode.get('updated');
    updated = _entityBuilder();
    updated.decode(rawUpdated);
    if(encode['previous'] != null){
      DataMap rawPrevious = encode.get('previous', null);
      previous = _entityBuilder();
      previous?.decode(rawPrevious);
    }
  }
}
