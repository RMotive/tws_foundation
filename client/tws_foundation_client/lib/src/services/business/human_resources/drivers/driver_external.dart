import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/human_resources/identifications/identification.dart';

/// {entity} class.
///
/// TODO: Define
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
    return <EntityInvalidation<DriverExternal>>[];
  }
}
