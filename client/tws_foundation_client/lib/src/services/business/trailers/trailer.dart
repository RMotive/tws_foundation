import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
///
final class Trailer extends EntityB<Trailer> {
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
    model = encode.getEntity(() => VehiculeModel(), kModel);
    carrier = encode.getEntity(() => Carrier(), kCarrier) ?? carrier;
    maintenance = encode.getEntity(() => Maintenance(), kMaintenance);
    sct = encode.getEntity(() => SCT(), FoundationCommonPropertyKeys.kSCT);

    List<DataMap> dmPlates = encode.getList(kPlates);
    plates = dmPlates.map(
      (Map<String, Object?> e) {
        Plate newPlate = Plate();
        newPlate.decode(e);

        return newPlate;
      },
    ).toList();

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kCarrier: carrier.encode(),
        FoundationCommonPropertyKeys.kSCT: sct?.encode(),
        kModel: model?.encode(),
        kMaintenance: maintenance?.encode(),
        kPlates: plates.map((Plate e) => e.encode()).toList(),
      },
    );
  }

  @override
  List<EntityInvalidation<Trailer>> evaluate() {
    return <EntityInvalidation<Trailer>>[];
  }
}
