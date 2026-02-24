import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Insurance  extends EntityBase<Insurance> {
  /// [policy] property key.
  static const String kPolicy = "policy";

  /// [country] property key.
  static const String kCountry = "country";

  /// [expiration] property key.
  static const String kExpiration = "expiration";

  /// Insurance policy number.
  /// rules >
  /// 21 > length > 0
  String policy = "";

  /// Country where the insurance is issued.
  /// rules >
  /// 4 > length > 0
  String country = "";

  /// Insurance expiration date.
  DateTime expiration = DateTime(0);

  /// Insurance status.
  Status status = Status();
  
  /// Creates a new [Insurance] instance.
  Insurance();

  /// Validate nulleable inputs to avoid [Insurance] entities with empty values.
  Insurance? sanitize({
    String? policy,
    String? country,
    DateTime? expiration,
  }) {
    this.policy = policy.sanitizeOrFallback(this.policy) ?? '';
    this.country = country.sanitizeOrFallback(this.country) ?? '';
    this.expiration = expiration ?? this.expiration;

    if (this.policy.isEmpty && this.country.isEmpty && this.expiration == DateTime(0)) {
      return null;
    }

    return this;
  }
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    policy = encode.get(kPolicy) ?? policy;
    country = encode.get(kCountry) ?? country;
    expiration = encode.get(kExpiration) ?? expiration;
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? status; 
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kPolicy: policy,
        kCountry: country,
        kExpiration: expiration.dateOnlyIso,
        FoundationCommonPropertyKeys.kStatus: status.encode(),
      },
    );
  }
  
  @override
  List<EntityErrors<Insurance>> evaluate(List<EntityErrors<Insurance>> errors) {
    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Insurance>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (policy.trim().isEmpty || policy.length > 20) {
      errors.add(
        EntityErrors<Insurance>(
          this,
          PropertyInfo(kPolicy, String, policy),
          'Length: ${policy.length}, cannot be empty or greater than 20 characters',
          '21 > length > 0',
        ),
      );
    }

    if(country.trim().isEmpty || country.length > 3) {
      errors.add(
        EntityErrors<Insurance>(
          this,
          PropertyInfo(kCountry, String, country),
          'lenght: ${country.length}, cannot be empty or greater than 3 characters',
          '4 > length > 0',
        ),
      );
    }

    errors.validateDependency(this, status);
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Insurance ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    List<ObjectDifference> statusDiff = status.compare(ref.status);

    if (policy != ref.policy) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kPolicy, String, policy),
          policy,
          ref.policy,
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