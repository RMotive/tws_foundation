import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents an external driver, wich are commonly third party businesses with alliances.
final class DriverExternal extends EntityBase<DriverExternal> {
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
    Status status = Status();
    Situation situation = Situation();
    status.reference = 'referdef';
    situation.reference = 'referdef';
    
    DriverCommon common = DriverCommon.a("licenseDef", status, situation);
    return super.encode(
      <String, Object?>{
        kIdentification: identification.encode(),
        'common': common.encode(),
      },
    );
  }

  @override
  List<EntityErrors<DriverExternal>> evaluate(List<EntityErrors<DriverExternal>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<DriverExternal>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }
    errors.validateDependency(this, identification);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
