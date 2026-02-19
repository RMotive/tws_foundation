import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
///
final class Trailer extends EntityBase<Trailer> {
  /// [Trailer.model] property key for [DataMap].
  static const String kModel = "model";

  /// [Trailer.carrier] property key for [DataMap].
  static const String kCarrier = "carrier";

  /// [Trailer.maintenance] property key for [DataMap].
  static const String kMaintenance = "maintenance";

  /// [Trailer.plates] property key for [DataMap].
  static const String kPlates = 'plates';

  //! --> Relations

  /// [Carrier] information.
  Carrier carrier = Carrier();

  /// [SCT] information.
  SCT? sct;

  /// [VehiculeModel] information.
  VehiculeModel? model;

  /// [Maintenance] information.
  Maintenance? maintenance;

  /// [Plate] collection.
  List<Plate> plates = <Plate>[];

  //! <-- Relations

  /// Creates a new [Trailer] instance.
  Trailer();

  @override
  void decode(DataMap encode) {
    carrier = encode.getEntity(() => Carrier(), kCarrier) ?? carrier;
    model = encode.getEntity(() => VehiculeModel(), kModel);
    maintenance = encode.getEntity(() => Maintenance(), kMaintenance);
    sct = encode.getEntity(() => SCT(), FoundationCommonPropertyKeys.kSCT);

    List<DataMap> platesMaps = encode.getList(kPlates);
    if (platesMaps.isNotEmpty) {
      plates = platesMaps.map<Plate>(
        (DataMap e) {
          Plate plate = Plate();
          plate.decode(e);
          return plate;
        },
      ).toList();
    }

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    TrailerCommon common = TrailerCommon();
    Status status = Status();
    status.reference = 'referdef';
    common.status = status;
    common.economic = "economicholder";
    return super.encode(
      <String, Object?>{
        kCarrier: carrier.encode(),
        FoundationCommonPropertyKeys.kSCT: sct?.encode(),
        kModel: model?.encode(),
        kMaintenance: maintenance?.encode(),
         kPlates: plates
            .map(
              (Plate e) => e.encode(),
            )
            .toList(),
        'common': common.encode(),
      },
    );
  }

  @override
  List<EntityErrors<Trailer>> evaluate(List<EntityErrors<Trailer>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
         EntityErrors<Trailer>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    errors.validateDependency(this, carrier);
    if(sct != null) errors.validateDependency(this, sct!);
    if(model != null) errors.validateDependency(this, model!);
    if(maintenance != null) errors.validateDependency(this, maintenance!);
    
    if (plates.isNotEmpty) {
      for (Plate plate in plates) {
        errors.validateDependency(this, plate);
      }
    }


    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
