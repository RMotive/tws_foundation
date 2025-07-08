import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [LoadType] default builder.
LoadType loadtypeBuilder() => LoadType();

/// Defines a business entity that stores the data for load types that can be asigned to [Trailer] entities.
final class LoadType extends NamedEntityB<LoadType> {
  
  /// Unique identificator reference.
  String reference = "";

  /// Generates a new [LoadType] instance from mandatory values.
  LoadType();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        FoundationCommonPropertyKeys.kReference: reference,
      }
    );
  }
  
  @override
  // ignore: unnecessary_overrides
  void decode(DataMap encode) {
    super.decode(encode);
    reference = encode.get(FoundationCommonPropertyKeys.kReference);
  }

  @override
  List<EntityInvalidation<LoadType>> evaluate() {
    List<EntityInvalidation<LoadType>> results = <EntityInvalidation<LoadType>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (reference.length != 8) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(FoundationCommonPropertyKeys.kReference, String, reference), "Reference value must contain 8 characters", "strictLength(8)"));
    if (description != null){
      if (description!.length > 200) {
        results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      }
      if (description!.trim().isEmpty) results.add(EntityInvalidation<LoadType>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;
  }

}
