import 'package:csm_client/csm_client.dart';

final class Status extends NamedEntityB<Status> {

  /// [reference] property key.
  static const String kReference = "reference";
  
  /// Unique identificator reference.
  String reference = "";
  
  /// Generates a new [Status] instance from mandatory values.
  Status();
  
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
  List<EntityInvalidation<Status>> evaluate() {
    List<EntityInvalidation<Status>> results = <EntityInvalidation<Status>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "strictLength(100)"));
    if (reference.trim().length != 8) results.add(EntityInvalidation<Status>(this, PropertyInfo(kReference, String, reference), "Reference value must contain 8 characters", "strictLength(8)"));
    if (description != null){
      if (description!.length > 200) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }

}
