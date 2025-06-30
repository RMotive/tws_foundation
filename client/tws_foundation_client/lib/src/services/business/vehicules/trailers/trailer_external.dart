import 'package:csm_client/csm_client.dart';

/// {entity} class.
final class TrailerExternal extends EntityB<TrailerExternal> {
  static const String kCarrier = "carrier";
  static const String kMxPlate = "mxPlate";
  static const String kUsaPlate = "usaPlate";

  //! --> Properties

  /// Carrier identification.
  String carrier = "";

  /// Mexican plate identifier.
  String? mxPlate = "";

  /// USA plate identifier.
  String? usaPlate = "";

  //! <-- Properties

  /// Creates a new [TrailerExternal] instance.
  TrailerExternal();

  @override
  void decode(DataMap encode) {
    carrier = encode.get(carrier);
    mxPlate = encode.get(kMxPlate);
    usaPlate = encode.get(kUsaPlate);

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kCarrier: carrier,
        kMxPlate: mxPlate,
        kUsaPlate: usaPlate,
      },
    );
  }

  @override
  List<EntityInvalidation<TrailerExternal>> evaluate() {
    return <EntityInvalidation<TrailerExternal>>[];
  }
}
