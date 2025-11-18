import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityB] that stores common information for [Truck] and [TruckExternal].
/// Each [TruckCommon] instance can have [internal] and [external] at the same time can only have one of them.
final class TruckCommon extends CommonEntityB<TruckCommon, Truck, TruckExternal> {
  /// [TruckCommon.economic] property key for [DataMap].
  static const String kEconomic = "economic";

  /// [TruckCommon.location] property key for [DataMap].
  static const String kLocation = "location";

  /// [TruckCommon.internal] property key for [DataMap].
  static const String kInternal = "internal";

  /// [TruckCommon.external] property key for [DataMap].
  static const String kExternal = "external";

  //! --> Properties

  /// Business economic identifier.
  ///
  /// Rules >
  ///   1. 17 > length > 0
  String economic = "";

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  /// [Situation] information.
  Situation? situation;

  /// [Location] information.
  Location? location;

  //! <-- Relations

  //! --> Getters

  /// Gets the display value for the current {truck} plates.
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
  /// Gets the available internal or external carrier name.
  String get carrier => internal != null
      ? internal!.carrier.name
      : external?.carrier ?? 'Empty carrier.';

  //! <-- Getters

  /// Creates a [TruckCommon] object with default properties.
  TruckCommon();

  @override
  void decode(DataMap encode) {
    economic = encode.get(kEconomic);

    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? Status();
    situation = encode.getEntity(() => Situation(), FoundationCommonPropertyKeys.kSituation);
    location = encode.getEntity(() => Location(), kLocation);
    internal = encode.getEntity(() => Truck(), kInternal);
    external = encode.getEntity(() => TruckExternal(), kExternal);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEconomic: economic,
        kLocation: location?.encode(),
        kInternal: internal?.encode(),
        kExternal: external?.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        FoundationCommonPropertyKeys.kSituation: situation?.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<TruckCommon>> evaluate() {
    final List<EntityInvalidation<TruckCommon>> invalidations = <EntityInvalidation<TruckCommon>>[];

    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<TruckCommon>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (economic.trim().isEmpty || economic.length > 16) {
      invalidations.add(
        EntityInvalidation<TruckCommon>(
          this,
          PropertyInfo(kEconomic, String, economic),
          'Wrong length ${economic.length}',
          '17 > length > 0',
        ),
      );
    }

    if (internal != null && external != null) {
      invalidations.add(EntityInvalidation<TruckCommon>(
        this,
        PropertyInfo(kExternal, TruckExternal, external),
        'Unique violation',
        'internal and external can\'t be set both',
      ));
    }
    
    invalidations.validateDependency(this, status);
    if (situation != null) invalidations.validateDependency(this, situation!);
    if (location != null) invalidations.validateDependency(this, location!);
    if (internal != null) invalidations.validateDependency(this, internal!);
    if (external != null) invalidations.validateDependency(this, external!);

    return invalidations;
  }

  @override
  TruckExternal externalFactory() {
    return TruckExternal();
  }
  
  @override
  Truck internalFactory() {
    return Truck();
  }
}
