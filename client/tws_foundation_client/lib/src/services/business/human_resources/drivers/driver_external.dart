import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/services/business/human_resources/identifications/identification.dart';

/// {entity} class.
///
/// Represents an external driver, wich are commonly third party businesses with alliances.
final class DriverExternal extends EntityB<DriverExternal> {
  /// [DriverExternal.identification] property key for [DataMap].
  static const String kIdentification = "identification";

  //! --> Relations

  /// [Identification] information.
  Identification identification = Identification();

  //! <-- Relations

  /// Creates a new [DriverExternal] instance.
  DriverExternal();

  @override
  void decode(DataMap encode) {
    identification = encode.getEntity(() => Identification(), kIdentification) ?? identification;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kIdentification: identification.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<DriverExternal>> evaluate() {
    List<EntityInvalidation<DriverExternal>> results = <EntityInvalidation<DriverExternal>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<DriverExternal>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));
    results.validateDependency(this, identification);

    return results;
  }
}
