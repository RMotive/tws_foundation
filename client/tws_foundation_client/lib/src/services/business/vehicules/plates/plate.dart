import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {entity} class.
final class Plate extends EntityBase<Plate> {
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
  List<EntityErrors<Plate>> evaluate(List<EntityErrors<Plate>> errors) {
    errors = super.evaluate(errors);

     if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Plate>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (identifier.trim().isEmpty || identifier.length > 12) {
      errors.add(
        EntityErrors<Plate>(
          this,
          PropertyInfo(kIdentifier, String, identifier),
          'Length: ${identifier.length}, cannot be empty and greatest than 12.',
          '13 > length > 0',
        ),
      );
    }

    if (country.trim().isEmpty || country.length > 3) {
      errors.add(
        EntityErrors<Plate>(
          this,
          PropertyInfo(kCountry, String, country),
          'Length: ${country.length}, cannot be empty and greatest than 3.',
          '4 > length > 0',
        ),
      );
    }

    if (state != null && (state!.trim().isEmpty || state!.length > 3)) {
      errors.add(
        EntityErrors<Plate>(
          this,
          PropertyInfo(kState, String, state),
          'Length: ${state!.length}, cannot be empty and greatest than 3.',
          '4 > length > 0',
        ),
      );
    }


    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Plate ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if (identifier != ref.identifier) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kIdentifier, String, identifier),
          identifier,
          ref.identifier,
          null,
        ),
      );
    }

    if (country != ref.country) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kCountry, String, country),
          country,
          ref.country,
          null,
        ),
      );
    }

    if (state != ref.state) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kState, String, state),
          state,
          ref.state,
          null,
        ),
      );
    }

    if (expiration != ref.expiration) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kExpiration, DateTime, expiration),
          expiration,
          ref.expiration,
          null,
        ),
      );
    }

    if(statusDiff.isNotEmpty){
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          statusDiff,
        ),
      );
    }

    return aggregated;
  }
}
