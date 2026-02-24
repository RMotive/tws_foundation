import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
final class TrailerExternal extends EntityBase<TrailerExternal> {
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
  String? carrier;

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
  List<EntityErrors<TrailerExternal>> evaluate(List<EntityErrors<TrailerExternal>> errors) {
    errors = super.evaluate(errors);
    
    if (id < BigInt.zero) {
      errors.add(
         EntityErrors<TrailerExternal>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          'id < 0',
        ),
      );
    }

    if (carrier != null && carrier!.length > 100 || carrier!.isEmpty) {
      errors.add(
        EntityErrors<TrailerExternal>(
          this,
          PropertyInfo(
            kCarrier,
            String,
            carrier,
          ),
          'Lenght: ${carrier!.length}, must be empty or between 1 and 100 characters.',
          '101 > length > 0',
        ),
      );
    }

    if ((usaPlate != null) && (usaPlate!.length > 7 || usaPlate!.length < 6)) {
      errors.add(
        EntityErrors<TrailerExternal>(
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
      errors.add(
        EntityErrors<TrailerExternal>(
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

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(TrailerExternal ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    if (carrier != ref.carrier) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCarrier, String, carrier),
          carrier,
          ref.carrier,
          null,
        ),
      );
    }

    if (mxPlate != ref.mxPlate) {
      aggregated.add(
          ObjectDifference(
            PropertyInfo(kMxPlate, String, mxPlate),
            mxPlate,
            ref.mxPlate,
            null,
          ),
        );
    }

    if (usaPlate != ref.usaPlate) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kUsaPlate, String, usaPlate),
          usaPlate,
          ref.usaPlate,
          null,
        ),
      );
    }
    
    return aggregated;
  }
}
