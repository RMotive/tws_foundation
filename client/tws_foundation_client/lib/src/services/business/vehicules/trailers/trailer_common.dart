import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityB] that stores common information for [Trailer] and [TrailerExternal].
/// Each [TrailerCommon] instance can have [internal] and [external] at the same time can only have one of them.
final class TrailerCommon extends CommonEntityB<TrailerCommon, Trailer, TrailerExternal> {
  /// [TrailerCommon.type] property key for [DataMap].
  static const String kType = "type";

  /// [TrailerCommon.location] property key for [DataMap].
  static const String kLocation = "location";

  /// [TrailerCommon.economic] property key for [DataMap].
  static const String kEconomic = "economic";

  /// [TrailerCommon.internal] property key for [DataMap].
  static const String kInternal = "internal";

  /// [TrailerCommon.external] property key for [DataMap].
  static const String kExternal = "external";

  //! --> Properties

  /// Business identifier number.
  ///
  /// Rules >
  ///   1. 17 > length > 0
  String economic = "";

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  /// [TrailerType] information.
  TrailerType? type;

  /// [Situation] information
  Situation? situation;

  /// [Location] informaiton.
  Location? location;

  //! <-- Relations

  //! --> Getters

  /// Gets the display value for the current {trailer} plates.
  ///
  /// Format: {USA Plate} / {MX Plate}
  String? get plates {
    if (internal == null && external == null) return null;

    if (internal != null) {
      List<Plate> plates = internal?.plates as List<Plate>;

      Plate? usPlate;
      Plate? mxPlate;

      for (Plate plate in plates) {
        if (plate.country == "MEX" && mxPlate == null) {
          mxPlate = plate;
        }

        if (plate.country == "USA" && usPlate == null) {
          usPlate = plate;
        }

        if (usPlate != null && mxPlate != null) {
          break;
        }
      }

      return '${usPlate?.identifier ?? '---'} ${mxPlate?.identifier ?? '---'}';
    }

    return '${external?.usaPlate ?? '---'} / ${external?.mxPlate ?? '---'}';
  }

  //! <-- Getters

  /// Creates a new [TrailerCommon] instance.
  TrailerCommon();

  @override
  void decode(DataMap encode) {
    economic = encode.get(kEconomic);

    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;
    type = encode.getEntity(() => TrailerType(), kType);
    situation = encode.getEntity(() => Situation(), FoundationCommonPropertyKeys.kSituation);
    location = encode.getEntity(() => Location(), kLocation);
    internal = encode.getEntity(() => Trailer(), kInternal);
    external = encode.getEntity(() => TrailerExternal(), kExternal);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEconomic: economic,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        kType: type?.encode(),
        FoundationCommonPropertyKeys.kSituation: situation?.encode(),
        kLocation: location?.encode(),
        kInternal: internal?.encode(),
        kExternal: external?.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<TrailerCommon>> evaluate() {
    final List<EntityInvalidation<TrailerCommon>> invalidations = <EntityInvalidation<TrailerCommon>>[];

    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<TrailerCommon>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (economic.trim().isEmpty || economic.length > 16) {
      invalidations.add(
        EntityInvalidation<TrailerCommon>(
          this,
          PropertyInfo(kEconomic, String, economic),
          'Wrong length ${economic.length}',
          '17 > length > 0',
        ),
      );
    }

    if (internal != null && external != null) {
      invalidations.add(EntityInvalidation<TrailerCommon>(
        this,
        PropertyInfo(kExternal, TruckExternal, external),
        'Unique violation',
        'internal and external can\'t be set both',
      ));
    }

    invalidations.validateDependency(this, status);
    if (type != null) invalidations.validateDependency(this, type!);
    if (situation != null) invalidations.validateDependency(this, situation!);
    if (location != null) invalidations.validateDependency(this, location!);
    if (internal != null) invalidations.validateDependency(this, internal!);
    if (external != null) invalidations.validateDependency(this, external!);
    return invalidations;
  }
  
  @override
  TrailerExternal externalFactory() {
    return TrailerExternal();
  }
  
  @override
  Trailer internalFactory() {
    return Trailer();
  }
}
