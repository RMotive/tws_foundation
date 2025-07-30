import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
final class Plate extends EntityB<Plate> {
  /// [Plate.identifier] property key for [DataMap].
  static const String kIdentifier = "identifier";

  /// [Plate.country] property key for [DataMap].
  static const String kCountry = "country";

  /// [Plate.state] property key for [DataMap].
  static const String kState = "state";

  /// [Plate.expiration] property key for [DataMap].
  static const String kExpiration = "expiration";

  //! --> Properties

  /// Plate identifier number.
  String identifier = "";

  /// Country the [Plate] is from.
  String country = "";

  /// Country state the [Plate] is from.
  String? state;

  /// Expiration date.
  DateTime? expiration;

  //! <-- Properties

  //! --> Relations

  /// [Status] information.
  Status status = Status();

  //! <-- Relations

  /// Creates a new [Plate] instance.
  Plate();

  @override
  void decode(DataMap encode) {
    identifier = encode.get(kIdentifier);
    country = encode.get(kCountry);
    state = encode.get(kState);
    expiration = encode.get(kExpiration);

    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status;

    super.decode(encode);
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kIdentifier: identifier,
        kCountry: country,
        kState: state,
        kExpiration: expiration?.dateOnlyIso,
        FoundationCommonPropertyKeys.kStatus: status,
      },
    );
  }

  @override
  List<EntityInvalidation<Plate>> evaluate() {
    return <EntityInvalidation<Plate>>[];
  }
}
