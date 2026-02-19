import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents a common entity model for [Driver] and [DriverExternal].
final class DriverCommon extends CommonEntityB<DriverCommon, Driver, DriverExternal> {
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
  Situation? situation = Situation();

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

    return ident.fullname;
  }

  //! <-- Getters

  /// Creates a new [DriverCommon] instance.
  DriverCommon();

  DriverCommon.a(this.license, this.status, this.situation);

  @override
  void decode(DataMap encode) {
    license = encode.get(kLicense);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    situation = encode.getEntity(() => Situation(), FoundationCommonPropertyKeys.kSituation);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kLicense: license,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        FoundationCommonPropertyKeys.kSituation: situation?.encode(),
      },
    );
  }

  @override
  List<EntityErrors<DriverCommon>> evaluate(List<EntityErrors<DriverCommon>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<DriverCommon>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (license.length > 12 || license.length < 8) {
      errors.add(
        EntityErrors<DriverCommon>(
          this,
          PropertyInfo(kLicense, String, license),
          'Length must be between 8 and 12 characters',
          '13 > length > 7',
        ),
      );
    }

    if (internal != null && external != null) {
      errors.add(EntityErrors<DriverCommon>(
        this,
        PropertyInfo(CorePropertiesConsts.name, DriverCommon, external),
        'Unique violation',
        'internal and external can\'t be set both',
      ));
    }

    errors.validateDependency(this, status);
    
    if (situation != null) errors.validateDependency(this, situation!);
    if (internal != null) errors.validateDependency(this, internal!);   
    if (external != null) errors.validateDependency(this, external!);

    return errors;
  }
  
  @override
  DriverExternal externalFactory() {
    return DriverExternal();
  }
  
  @override
  Driver internalFactory() {
    return Driver();
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
