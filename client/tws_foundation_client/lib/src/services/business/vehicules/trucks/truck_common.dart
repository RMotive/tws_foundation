import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityBase] that stores common information for [Truck] and [TruckExternal].
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
  List<EntityErrors<TruckCommon>> evaluate(List<EntityErrors<TruckCommon>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<TruckCommon>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (economic.trim().isEmpty || economic.length > 16) {
      errors.add(
        EntityErrors<TruckCommon>(
          this,
          PropertyInfo(kEconomic, String, economic),
          'Wrong length ${economic.length}',
          '17 > length > 0',
        ),
      );
    }

    if (internal != null && external != null) {
      errors.add(EntityErrors<TruckCommon>(
        this,
        PropertyInfo(kExternal, TruckExternal, external),
        'Unique violation',
        'internal and external can\'t be set both',
      ));
    }
    
    errors.validateDependency(this, status);
    if (situation != null) errors.validateDependency(this, situation!);
    if (location != null) errors.validateDependency(this, location!);
    if (internal != null) errors.validateDependency(this, internal!);
    if (external != null) errors.validateDependency(this, external!);

    return errors;
  }

  @override
  TruckExternal externalFactory() {
    return TruckExternal();
  }
  
  @override
  Truck internalFactory() {
    return Truck();
  }
  
  @override
  List<ObjectDifference> compare(TruckCommon ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if(economic != ref.economic){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEconomic, String, economic),
          economic,
          ref.economic,
          null,
        ),
      );
    }

    if (statusDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
      );
    }

    if (ref.situation != null) {
      List<ObjectDifference> situationDiff = situation?.compare(ref.situation!) ?? <ObjectDifference>[];
      if (situationDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(FoundationCommonPropertyKeys.kSituation, Situation, situation),
            situation,
            ref.situation,
            situationDiff,
          ),
        );
      }
    } 

    if (ref.location != null) {
      List<ObjectDifference> locationDiff = location?.compare(ref.location!) ?? <ObjectDifference>[];
      if (locationDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kLocation, Location, location),
            location,
            ref.location,
            locationDiff,
          ),
        );
      }
    }

    return aggregated;

  }
}
