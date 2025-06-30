import 'package:csm_client/csm_client.dart';

final class TrailerClass extends NamedEntityB<TrailerClass> {

  /// Generates a new [TrailerClass] instance from mandatory values.
  TrailerClass();

  factory TrailerClass.factory(String name, {String? description}) {
    TrailerClass trailerClass = TrailerClass();
    trailerClass.name = name;
    trailerClass.description = description;
    
    return trailerClass;
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
  List<EntityInvalidation<TrailerClass>> evaluate() {
    List<EntityInvalidation<TrailerClass>> results = <EntityInvalidation<TrailerClass>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<TrailerClass>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<TrailerClass>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<TrailerClass>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<TrailerClass>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }

}
