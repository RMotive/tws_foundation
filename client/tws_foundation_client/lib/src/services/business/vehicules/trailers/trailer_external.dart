import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
final class TrailerExternal extends EntityB<TrailerExternal> {
  /// [TrailerExternal.carrier] property key for [DataMap].
  static const String kCarrier = "carrier";

  /// [TrailerExternal.mxPlate] property key for [DataMap].
  static const String kMxPlate = "mxPlate";

  /// [TrailerExternal.usaPlate] property key for [DataMap].
  static const String kUsaPlate = "usaPlate";

  //! --> Properties

  /// Carrier identification.
  /// 
  /// rules > 
  ///   1. 101 > length > 0
  String carrier = "";

  /// Mexican plate identifier.
  /// 
  /// rules > 
  ///  1. length == 7
  String? mxPlate = "";

  /// USA plate identifier.
  /// 
  /// rules > 
  ///   1. 8 > length > 4
  String? usaPlate = "";

  //! <-- Properties

  /// Creates a new [TrailerExternal] instance.
  TrailerExternal();

  @override
  void decode(DataMap encode) {
    carrier = encode.get(kCarrier) ?? carrier;
    mxPlate = encode.get(kMxPlate);
    usaPlate = encode.get(kUsaPlate);

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
        kCarrier: carrier,
        kMxPlate: mxPlate,
        kUsaPlate: usaPlate,
        'common': common.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<TrailerExternal>> evaluate() {
    List<EntityInvalidation<TrailerExternal>> invalidations = <EntityInvalidation<TrailerExternal>>[];
    
    if (id < BigInt.zero) {
      invalidations.add(
         EntityInvalidation<TrailerExternal>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          'id < 0',
        ),
      );
    }

    if (carrier.length > 100 || carrier.isEmpty) {
      invalidations.add(
        EntityInvalidation<TrailerExternal>(
          this,
          PropertyInfo(
            kCarrier,
            String,
            carrier,
          ),
          'Lenght: ${carrier.length}, must be between 1 and 100 characters.',
          '101 > length > 0',
        ),
      );
    }

    if ((usaPlate != null) && (usaPlate!.length > 7 || usaPlate!.length < 6)) {
      invalidations.add(
        EntityInvalidation<TrailerExternal>(
          this,
          PropertyInfo(
            kUsaPlate,
            String,
            usaPlate,
          ),
          'Length: ${usaPlate!.length}, must be between 5 and 7 characters.',
          '8 > length > 4',
        ),
      );
    }

    if ((mxPlate != null) && (mxPlate!.length != 7)) {
      invalidations.add(
        EntityInvalidation<TrailerExternal>(
          this,
          PropertyInfo(
            kMxPlate,
            String,
            mxPlate,
          ),
          'Length: ${mxPlate!.length}, Must be equal to 7 characters.',
          'length == 7',
        ),
      );
    }

    return invalidations;
  }
}
