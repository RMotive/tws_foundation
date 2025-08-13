import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Insurance  extends EntityB<Insurance> {
  /// [policy] property key.
  static const String kPolicy = "policy";

  /// [country] property key.
  static const String kCountry = "country";

  /// [expiration] property key.
  static const String kExpiration = "expiration";

  /// Insurance policy number.
  String policy = "";

  /// Country where the insurance is issued.
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
  List<EntityInvalidation<Insurance>> evaluate() {
    List<EntityInvalidation<Insurance>> invalidations = <EntityInvalidation<Insurance>>[];
    if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<Insurance>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (policy.trim().isEmpty || policy.length > 20) {
      invalidations.add(
        EntityInvalidation<Insurance>(
          this,
          PropertyInfo(kPolicy, String, policy),
          'Length: ${policy.length}, cannot be empty or greater than 20 characters',
          '21 > length > 0',
        ),
      );
    }

    if(country.trim().isEmpty || country.length > 3) {
      invalidations.add(
        EntityInvalidation<Insurance>(
          this,
          PropertyInfo(kCountry, String, country),
          'lenght: ${country.length}, cannot be empty or greater than 3 characters',
          '3 > length > 0',
        ),
      );
    }

    invalidations.validateDependency(this, status);
    return invalidations;
  }
  

}