import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';

final class Approach extends EntityB<Approach> {
  
  /// [email] property key.
  static const String kEmail = "email";

  /// [enterprise] property key.
  static const String kEnterprise = "enterprise";

  /// [personal] property key.
  static const String kPersonal = "personal";

  /// [alternative] property key.
  static const String kAlternative = "alternative";

  /// [carriers] property key.
  static const String kCarriers = "Carriers";

  /// contact email.
  String email = "";

  /// enterprise name.
  String? enterprise;

  /// personal phone number.
  String? personal;

  /// Alternative contact data.
  String? alternative;

  /// [Status] object.
  Status? status;
  
  /// Generates a new [Solution] instance from mandatory values.
  Approach();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEmail: email,
        kEnterprise: enterprise,
        kPersonal: personal,
        kAlternative: alternative,
        EntitiesCommonProperties.kStatus: status?.encode(),
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    email = encode.get(kEmail);
    enterprise = encode.get(kEnterprise);
    personal = encode.get(kPersonal);
    alternative = encode.get(kAlternative);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }  
  }

  @override
  List<EntityInvalidation<Approach>> evaluate() {
    List<EntityInvalidation<Approach>> results = <EntityInvalidation<Approach>>[];

    if(email.length > 64) results.add(EntityInvalidation<Approach>(this, PropertyInfo(kEmail, String, email), "Email must be 64  max length", "strictLength(1, 64)"));
    if(enterprise != null){
      if(enterprise!.length < 10 || enterprise!.length > 14) results.add(EntityInvalidation<Approach>(this, PropertyInfo(kEnterprise, String, enterprise), "Enterprise number length must be between 10 and 14", "strictLength(1,4)"));
    }
     
    if(personal != null){
      if(personal!.length < 10 || personal!.length > 14) results.add(EntityInvalidation<Approach>(this, PropertyInfo(kPersonal, String, personal), "Personal number length must be between 10 and 14", "strictLength(1,4)"));
    }

    if(alternative != null && alternative!.length > 30) results.add(EntityInvalidation<Approach>(this, PropertyInfo(kAlternative, String, alternative), "Alternative contact must be 30  max length", "strictLength(0, 30)"));    
    
    return results;
  }

}
