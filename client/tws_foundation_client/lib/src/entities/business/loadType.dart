import 'package:csm_client/csm_client.dart';

final class Loadtype extends NamedEntityB<Loadtype> {

  /// Generates a new [Loadtype] instance from mandatory values.
  Loadtype();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode();
  }
  
  @override
  // ignore: unnecessary_overrides
  void decode(DataMap encode) {
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<Loadtype>> evaluate() {
    List<EntityInvalidation<Loadtype>> results = <EntityInvalidation<Loadtype>>[];
    return results;
  }

}
