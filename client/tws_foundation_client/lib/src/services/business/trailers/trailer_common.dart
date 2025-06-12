import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
///
///
final class TrailerCommon extends EntityB<TrailerCommon> {
  static const String kType = "type";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kInternal = "internal";
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

  /// [Trailer] (internal) information.
  Trailer? internal;

  // [TrailerExternal] information.
  TrailerExternal? external;

  //! <-- Relations

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
    return <EntityInvalidation<TrailerCommon>>[];
  }
}
