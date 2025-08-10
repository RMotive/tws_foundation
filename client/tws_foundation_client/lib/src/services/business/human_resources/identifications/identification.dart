import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// TODO: Define
final class Identification extends EntityB<Identification> {
  /// [Identification.lastName] property key for [DataMap].
  static const String kLastName = "lastName";

  /// [Identification.birthDay] property key for [DataMap].
  static const String kBirthday = "birthDay";

  //! --> Properties

  /// Physical person name.
  /// For more than one name split with space.
  String name = "";

  /// Physical person last name.
  ///
  /// For more than one last name split with space.
  String lastName = "";

  /// Persona bith day.
  DateTime? birthDay;

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [Identification] instance.
  Identification();

  @override
  void decode(DataMap encode) {
    name = encode.get(EntityKeys.name);
    lastName = encode.get(kLastName);
    birthDay = encode.get(kBirthday);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        EntityKeys.name: name,
        kLastName: lastName,
        kBirthday: birthDay?.dateOnlyIso,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Identification>> evaluate() {
    List<EntityInvalidation<Identification>> results = <EntityInvalidation<Identification>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Identification>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 32) results.add(EntityInvalidation<Identification>(this, PropertyInfo(EntityKeys.name, String, name), "Name must be 32 max length", "structLength(32)"));
    if (lastName.trim().isEmpty || name.length > 32) results.add(EntityInvalidation<Identification>(this, PropertyInfo(kLastName, String, lastName), "Name must be 32 max length", "structLength(32)"));
    results.validateDependency(this, status);

    return results;
  }
}
