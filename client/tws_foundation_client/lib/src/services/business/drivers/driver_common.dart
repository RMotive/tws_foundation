import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents a common entity model for [Driver] and [DriverExternal].
final class DriverCommon extends EntityB<DriverCommon> {
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

  /// [Driver] information.
  Driver? internal;

  /// [DriverExternal] information.
  DriverExternal? external;

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

    DataMap dmStatus = encode.get(FoundationCommonPropertyKeys.kStatus);
    status.decode(dmStatus);

    DataMap dmSituation = encode.get(FoundationCommonPropertyKeys.kSituation);
    situation.decode(dmSituation);

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

    return invalidations;
  }
}
