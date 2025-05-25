import 'package:csm_client/csm_client.dart';

final class Loadtype extends NamedEntityB<Loadtype> {

  /// Generates a new [Loadtype] instance from mandatory values.
  Loadtype();

  factory Loadtype.factory(String name, {String? description}) {
    Loadtype loadtype = Loadtype();
    loadtype.name = name;
    loadtype.description = description;
    
    return loadtype;
  }
  
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
    if (id < BigInt.zero) results.add(EntityInvalidation<Loadtype>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Loadtype>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Loadtype>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Loadtype>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }

}
