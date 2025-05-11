import 'package:csm_client/csm_client.dart';

final class TrailerClass extends NamedEntityB<TrailerClass> {

  /// Generates a new [TrailerClass] instance from mandatory values.
  TrailerClass();
  
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
  List<EntityInvalidation<TrailerClass>> evaluate() {
    List<EntityInvalidation<TrailerClass>> results = <EntityInvalidation<TrailerClass>>[];
    return results;
  }

}
