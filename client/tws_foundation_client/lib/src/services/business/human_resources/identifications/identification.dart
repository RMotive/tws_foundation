import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// TODO: Define
final class Identification extends EntityBase<Identification> {
  /// [Identification.firstLastName] property key for [DataMap].
  static const String kFirstLastName = "firstLastName";

    /// [Identification.secondLastName] property key for [DataMap].
  static const String kSecondLastName = "secondLastName";

  /// [Identification.birthDay] property key for [DataMap].
  static const String kBirthday = "birthDay";

  //! --> Properties

  /// Physical person name.
  /// 
  /// rules > 
  /// 33 > Length > 0
  String name = "";

  /// Physical person first last name.
  /// 
  /// rules >
  /// 33 > Length > 0
  String firstLastName = "";
  
  /// Physical person second last name.
  /// 
  /// rules >
  /// 33 > Length
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

  /// Gets the full name of the identified person.
  String get fullname => '$name $firstLastName ${secondLastName ?? ""}'.trim();

  @override
  void decode(DataMap encode) {
    name = encode.get(CorePropertiesConsts.name);
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
        CorePropertiesConsts.name: name,
        kFirstLastName: firstLastName,
        kSecondLastName: secondLastName,
        kBirthday: birthDay?.dateOnlyIso,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityErrors<Identification>> evaluate(List<EntityErrors<Identification>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) errors.add(EntityErrors<Identification>(this, PropertyInfo(CorePropertiesConsts.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    if (name.trim().isEmpty || name.length > 32) errors.add(EntityErrors<Identification>(this, PropertyInfo(CorePropertiesConsts.name, String, name), "Name must be 32 max length", "structLength(32)"));
    if (firstLastName.trim().isEmpty || firstLastName.length > 32) errors.add(EntityErrors<Identification>(this, PropertyInfo(kFirstLastName, String, firstLastName), "First last name must be 32 max length", "structLength(32)"));
    if (secondLastName != null && (secondLastName!.trim().isEmpty || secondLastName!.length > 32)) errors.add(EntityErrors<Identification>(this, PropertyInfo(kSecondLastName, String, secondLastName), "Second last name must be 32 max length or be empty", "structLength(32)"));

    errors.validateDependency(this, status);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
