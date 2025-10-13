import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// TODO: Define
final class Identification extends EntityB<Identification> {
  /// [Identification.firstLastName] property key for [DataMap].
  static const String kFirstLastName = "firstLastName";

    /// [Identification.secondLastName] property key for [DataMap].
  static const String kSecondLastName = "secondLastName";

  /// [Identification.birthDay] property key for [DataMap].
  static const String kBirthday = "birthDay";

  //! --> Properties

  /// Physical person name.
  /// For more than one name split with space.
  String name = "";

  /// Physical person first last name.
  String firstLastName = "";
  
  /// Physical person second last name.
  String? secondLastName;

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
    firstLastName = encode.get(kFirstLastName);
    secondLastName = encode.get(kSecondLastName);
    birthDay = encode.get(kBirthday);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        EntityKeys.name: name,
        kFirstLastName: firstLastName,
        kSecondLastName: secondLastName,
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
    if (firstLastName.trim().isEmpty || name.length > 32) results.add(EntityInvalidation<Identification>(this, PropertyInfo(kFirstLastName, String, firstLastName), "First last name must be 32 max length", "structLength(32)"));
    if (secondLastName != null && (secondLastName!.trim().isEmpty || name.length > 32)) results.add(EntityInvalidation<Identification>(this, PropertyInfo(kSecondLastName, String, secondLastName), "Second last name must be 32 max length or be empty", "structLength(32)"));

    results.validateDependency(this, status);

    return results;
  }
}
