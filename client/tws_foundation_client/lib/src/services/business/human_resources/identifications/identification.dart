import 'package:csm_client/csm_client.dart';
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
  ///
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

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        EntityKeys.name: name,
        kLastName: lastName,
        kBirthday: birthDay?.toIso8601String(),
      },
    );
  }

  @override
  List<EntityInvalidation<Identification>> evaluate() {
    return <EntityInvalidation<Identification>>[];
  }
}
