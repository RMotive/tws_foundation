import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Implements a [EntityBase] that stores common information for [Trailer] and [TrailerExternal].
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

  /// Gets the current {trailer} class and size concatenated string.
  /// 
  /// Format: {trailer class} - {trailer size}
  String? get classType {
    if (type != null) return '${type?.trailerClass.name} - ${type?.size}';
    return null;
  }

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
  List<EntityErrors<TrailerCommon>> evaluate(List<EntityErrors<TrailerCommon>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<TrailerCommon>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer cannot be less than 0',
          'invalidPointer()',
        ),
      );
    }

    if (economic.trim().isEmpty || economic.length > 16) {
      errors.add(
        EntityErrors<TrailerCommon>(
          this,
          PropertyInfo(kEconomic, String, economic),
          'Wrong length ${economic.length}',
          '17 > length > 0',
        ),
      );
    }

    if (internal != null && external != null) {
      errors.add(EntityErrors<TrailerCommon>(
        this,
        PropertyInfo(kExternal, TruckExternal, external),
        'Unique violation',
        'internal and external can\'t be set both',
      ));
    }

    errors.validateDependency(this, status);
    if (type != null) errors.validateDependency(this, type!);
    if (situation != null) errors.validateDependency(this, situation!);
    if (location != null) errors.validateDependency(this, location!);
    if (internal != null) errors.validateDependency(this, internal!);
    if (external != null) errors.validateDependency(this, external!);
    return errors;
  }
  
  @override
  TrailerExternal externalFactory() {
    return TrailerExternal();
  }
  
  @override
  Trailer internalFactory() {
    return Trailer();
  }
  
  @override
  List<ObjectDifference> compare(TrailerCommon ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if (economic != ref.economic) {
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

    if (ref.type != null) {
      List<ObjectDifference> typeDiff = type?.compare(ref.type!) ?? <ObjectDifference>[];
      if (typeDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kType, TrailerType, type),
            type,
            ref.type,
            typeDiff,
          ),
        );
      }
    }
    
    if (ref.situation != null){
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
    
    if(ref.location != null){
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
    
    if(ref.internal != null){
      List<ObjectDifference> internalDiff = internal?.compare(ref.internal!) ?? <ObjectDifference>[];

      if (internalDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kInternal, Trailer, internal),
            internal,
            ref.internal,
            internalDiff,
          ),
        );
      }
    }

    
    if(ref.internal != null){
      List<ObjectDifference> externalDiff = external?.compare(ref.external!) ?? <ObjectDifference>[];

      if (externalDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kExternal, TrailerExternal, external),
            external,
            ref.external,
            externalDiff,
          ),
        );
      }
    }

    return aggregated;
  }
}
