import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
/// Represents an external business truck usually from partners that needs to be loaded into own systems
/// for entry control or movement calulations.
final class TruckExternal extends EntityBase<TruckExternal> {
  /// [TruckExternal.carrier] property key for [DataMap].
  static const String kCarrier = "carrier";

  /// [TruckExternal.vin] property key for [DataMap].
  static const String kVin = "vin";

  /// [TruckExternal.usaPlate] property key for [DataMap].
  static const String kUsaPlate = "usaPlate";

  /// [TruckExternal.mxPlate] property key for [DataMap].
  static const String kMxPlate = "mxPlate";

  //! --> Properties

  /// Carrier identificator.
  ///
  /// Rules >
  ///   1. 101 > length > 0
  String carrier = "";

  /// Vehicule identifier number.
  ///
  /// Rules >
  ///   1. 18 > length > 0
  String? vin;

  /// USA Plate number.
  ///
  /// Rules >
  ///   1. 8 > length > 5
  String? usaPlate;

  /// MX Plate number.
  ///
  /// Rules >
  ///   1. length == 7
  String? mxPlate;

  //! <-- Properties

  /// Creates a new [TruckExternal] instance.
  TruckExternal();

  @override
  void decode(DataMap encode) {
    carrier = encode.get(kCarrier);
    vin = encode.get(kVin);
    usaPlate = encode.get(kUsaPlate);
    mxPlate = encode.get(kMxPlate);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    TruckCommon common = TruckCommon();
    Status status = Status();
    status.reference = 'referdef';
    common.status = status;
    common.economic = "economicholder";

    return super.encode(
      <String, Object?>{
        kCarrier: carrier,
        kVin: vin,
        kUsaPlate: usaPlate,
        kMxPlate: mxPlate,
        'common': common.encode(),
      },
    );
  }

  @override
  List<EntityErrors<TruckExternal>> evaluate(List<EntityErrors<TruckExternal>> errors) {
    errors = super.evaluate(errors);

    if (carrier.length > 100 || carrier.isEmpty) {
      errors.add(
        EntityErrors<TruckExternal>(
          this,
          PropertyInfo(
            kCarrier,
            String,
            carrier,
          ),
          'Wrong length ${carrier.length}',
          '101 > length > 0',
        ),
      );
    }

    if ((vin != null) && (vin!.length > 17 || vin!.isEmpty)) {
      errors.add(
        EntityErrors<TruckExternal>(
          this,
          PropertyInfo(
            kVin,
            String,
            vin,
          ),
          'Wrong length ${vin!.length}',
          '18 > length > 0',
        ),
      );
    }

    if ((usaPlate != null) && (usaPlate!.length > 7 || usaPlate!.length < 6)) {
      errors.add(
        EntityErrors<TruckExternal>(
          this,
          PropertyInfo(
            kUsaPlate,
            String,
            usaPlate,
          ),
          'Wrong length ${usaPlate!.length}',
          '8 > length > 5',
        ),
      );
    }

    if ((mxPlate != null) && (mxPlate!.length != 7)) {
      errors.add(
        EntityErrors<TruckExternal>(
          this,
          PropertyInfo(
            kMxPlate,
            String,
            mxPlate,
          ),
          'Wrong length ${mxPlate!.length}',
          'length == 7',
        ),
      );
    }

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(ref, [List<ObjectDifference>? aggregated]) {
    // TODO: implement compare
    throw UnimplementedError();
  }
}
