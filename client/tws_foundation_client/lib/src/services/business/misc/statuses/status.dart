import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements from [NamedEntityB], representing a {csm} business entity storing information
/// to represent a status for related entities.
final class Status extends NamedEntityB<Status> {

  /// Unique identificator reference.
  String reference = "";

  /// Creates a new [Status] instance.
  Status();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    reference = encode.get(FoundationCommonPropertyKeys.kReference);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        FoundationCommonPropertyKeys.kReference: reference,
      }
    );
  }

  @override
  List<EntityInvalidation<Status>> evaluate() {
    List<EntityInvalidation<Status>> results = <EntityInvalidation<Status>>[];

    if (id < BigInt.zero) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (reference.length != 8) results.add(EntityInvalidation<Status>(this, PropertyInfo(FoundationCommonPropertyKeys.kReference, String, reference), 'References characters lengh must be 8', 'strictLenght(8)'));
    if (name.trim().isEmpty || name.length > 100) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 100 max length", "structLength(100)"));
    if (description != null) {
      if (description!.length > 200) {
        results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.description, String, description), "Description must be 200 max length", "strictLength(200)"));
      }
      if (description!.trim().isEmpty) results.add(EntityInvalidation<Status>(this, PropertyInfo(EntityKeys.description, String, description), "Description is empty but not null.", "notEmpty()"));
    }
    return results;

  }
}
