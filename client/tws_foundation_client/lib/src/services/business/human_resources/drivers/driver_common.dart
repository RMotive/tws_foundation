import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents a common entity model for [Driver] and [DriverExternal].
final class DriverCommon extends CommonEntityB<DriverCommon, Driver, DriverExternal>
    implements EncodableI, EntityI<DriverCommon> {
  /// [DriverCommon.license] property key access for [DataMap].
  static const String kLicense = "license";

  //! --> Properties

  /// License identification number.
  ///
  /// Rules >
  ///   1. 13 > length > 9
  String license = "";

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  /// [Situation] information.
  Situation situation = Situation();

  //! <-- Relations

  //! --> Getters

  /// Gets the {driver} name.
  String? get name {
    Identification? ident;

    if (internal != null) {
      ident = internal?.employee.identification;
    } else {
      ident = external?.identification;
    }

    if (ident == null) return null;

    return '${ident.name} ${ident.lastName}';
  }

  //! <-- Getters

  /// Creates a new [DriverCommon] instance.
  DriverCommon();

  @override
  void decode(DataMap encode) {
    license = encode.get(kLicense);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    situation = encode.getEntity(() => Situation(), FoundationCommonPropertyKeys.kSituation) ?? situation;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kLicense: license,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        FoundationCommonPropertyKeys.kSituation: situation.encode(),

      },
    );
  }

  @override
  List<EntityInvalidation<DriverCommon>> evaluate() {
    final List<EntityInvalidation<DriverCommon>> invalidations = <EntityInvalidation<DriverCommon>>[];

    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<DriverCommon>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (license.length > 12 || license.length < 8) {
      invalidations.add(
        EntityInvalidation<DriverCommon>(
          this,
          PropertyInfo(kLicense, String, license),
          'Wrong length ${license.length}',
          '13 > length > 9',
        ),
      );
    }

    invalidations.validateDependency(this, status);
    invalidations.validateDependency(this, situation);
    
    if (internal != null) invalidations.validateDependency(this, internal!);   
    if (external != null) invalidations.validateDependency(this, external!);

    return invalidations;
  }
  
  @override
  DriverExternal externalFactory() {
    return DriverExternal();
  }
  
  @override
  Driver internalFactory() {
    return Driver();
  }
}
