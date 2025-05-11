import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Insurance extends EntityB<Insurance> {

  /// [country] property key.
  static const String kCountry = "country";

  /// [policy] property key.
  static const String kPolicy = "policy";

  /// [expiration] property key.
  static const String kExpiration = "expiration";

  /// Policy identification value.
  String policy = "";

  /// Source country.
  String country = "";

  /// Expiration time.
  DateTime expiration = DateTime(0);

  /// Foreign relation [Status] object.
  Status? status;

  /// Generates a new [Insurance] instance from mandatory values.
  Insurance();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kPolicy: policy,
          kCountry: country,
          kExpiration: expiration.toUtc().toIso8601String(),
          EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    policy = encode.get(kPolicy);
    country = encode.get(kCountry);
    expiration = encode.get(kExpiration);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, DataMap()));
    }
  }

  @override
  List<EntityInvalidation<Insurance>> evaluate() {
    List<EntityInvalidation<Insurance>> results = <EntityInvalidation<Insurance>>[];

    if(policy.length > 20) results.add(EntityInvalidation<Insurance>(this, PropertyInfo(kPolicy, String, policy), "Policy must be 20 length", "strictLength(20)"));
    if(country.length < 2 || country.length > 3) results.add(EntityInvalidation<Insurance>(this, PropertyInfo(kCountry, String, country),"Country must be between 2 and 3 length", "strictLength(2,3)"));
    if(expiration == DateTime(0)) results.add(EntityInvalidation<Insurance>(this, PropertyInfo(kExpiration, DateTime, expiration), 'Invalid expiration value.', 'invalidDate()'));

    return results;
  }

}
