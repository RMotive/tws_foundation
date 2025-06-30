import 'package:csm_client/csm_client.dart';

final class LoadType extends NamedEntityB<LoadType> {

  /// Generates a new [LoadType] instance from mandatory values.
  LoadType();

  factory LoadType.factory(String name, {String? description}) {
    LoadType loadtype = LoadType();
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
  List<EntityInvalidation<LoadType>> evaluate() {
    List<EntityInvalidation<LoadType>> results = <EntityInvalidation<LoadType>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200)
        results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }

}
