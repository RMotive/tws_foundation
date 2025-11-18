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
  /// rules >
  /// 1 : 13 > length > 0
  String identifier = "";

  /// Country the [Plate] is from.
  /// rules >
  /// 1 : 4 > length > 1 
  String country = "";

  /// Country state the [Plate] is from.
  /// rules >
  /// 1 : 4 > length > 1 
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
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }

  @override
  List<EntityInvalidation<Plate>> evaluate() {
    List<EntityInvalidation<Plate>> results = <EntityInvalidation<Plate>>[];

     if (id < BigInt.zero) {
      results.add(
        EntityInvalidation<Plate>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (identifier.trim().isEmpty || identifier.length > 12) {
      results.add(
        EntityInvalidation<Plate>(
          this,
          PropertyInfo(kIdentifier, String, identifier),
          'Length: ${identifier.length}, cannot be empty and greatest than 12.',
          '13 > length > 0',
        ),
      );
    }

    if (country.trim().isEmpty || country.length > 3) {
      results.add(
        EntityInvalidation<Plate>(
          this,
          PropertyInfo(kCountry, String, country),
          'Length: ${country.length}, cannot be empty and greatest than 3.',
          '4 > length > 0',
        ),
      );
    }

    if (state != null && (state!.trim().isEmpty || state!.length > 3)) {
      results.add(
        EntityInvalidation<Plate>(
          this,
          PropertyInfo(kState, String, state),
          'Length: ${state!.length}, cannot be empty and greatest than 3.',
          '4 > length > 0',
        ),
      );
    }


    return results;
  }
}
