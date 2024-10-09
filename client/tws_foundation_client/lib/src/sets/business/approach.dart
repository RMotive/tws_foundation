import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Approach implements CSMSetInterface {

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

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

   /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Alternative contact email.
  String email = "";

  /// Alternative contact enterprise.
  String? enterprise = "";

  /// Alternative contact personal.
  String? personal = "";

  /// Alternative contact alternative.
  String? alternative = "";

  /// Alternative contact [Status] object.
  Status? statusNavigation;

  /// List of carriers with the current alternative information related.
  List<Carrier> carriers = <Carrier>[];

  /// Creates an [Approach] object with required properties.
  Approach(this.id, this.status, this.email, this.enterprise, this.personal, this.alternative, this.statusNavigation, this.carriers, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  
  /// Creates an [Approach] object with default properties.
  Approach.a();

  /// Creates an [Approach] object based on a [json] object.
  factory Approach.des(JObject json) {
    List<Carrier> carriers = <Carrier>[];
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String email = json.get(kEmail);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String? enterprise = json.getDefault(kEnterprise, null);
    String? personal = json.getDefault(kPersonal, null);
    String? alternative = json.getDefault(kAlternative, null);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    List<JObject> rawCarriersArray = json.getList(kCarriers);
    carriers = rawCarriersArray.map<Carrier>(Carrier.des).toList();
    
    return Approach(id, status, email, enterprise, personal, alternative, statusNavigation, carriers, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kEmail: email,
      kEnterprise: enterprise,
      kPersonal: personal,
      kAlternative: alternative,
      SCK.kStatusNavigation: statusNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
      kCarriers: carriers.map((Carrier i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(email.length > 64) results.add(CSMSetValidationResult(kEmail, "Email must be 64  max length", "strictLength(1, 64)"));
    if(enterprise != null){
      if(enterprise!.length < 10 || enterprise!.length > 14) results.add(CSMSetValidationResult(kEnterprise, "Enterprise number length must be between 10 and 14", "strictLength(1,4)"));
    }
     
    if(personal != null){
      if(personal!.length < 10 || personal!.length > 14) results.add(CSMSetValidationResult(kPersonal, "Personal number length must be between 10 and 14", "strictLength(1,4)"));
    }

    if(alternative != null && alternative!.length > 30) results.add(CSMSetValidationResult(kAlternative, "Alternative contact must be 30  max length", "strictLength(0, 30)"));

    return results;
  }

  /// Creates an [Approach] object overriding the given properties.
  Approach clone({
    int? id,
    int? status,
    String? email,
    String? enterprise,
    String? personal,
    String? alternative,
    Status? statusNavigation,
    List<Carrier>? carriers
  }){
    return Approach(
      id ?? this.id, 
      status ?? this.status, 
      email ?? this.email, 
      enterprise ?? this.enterprise, 
      personal ?? this.personal, 
      alternative ?? this.alternative, 
      statusNavigation ?? this.statusNavigation, 
      carriers ?? this.carriers
    );
  }
  
}

