import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Approach implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kEmail = "email";
  static const String kEnterprise = "enterprise";
  static const String kPersonal = "personal";
  static const String kTimestamp = "timestamp";
  static const String kAlternative = "alternative";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kCarriers = "Carriers";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  String email = "";
  String? enterprise = "";
  String? personal = "";
  String? alternative = "";
  Status? statusNavigation;
  List<Carrier> carriers = <Carrier>[];

  Approach(this.id, this.status, this.email, this.enterprise, this.personal, this.alternative, this.statusNavigation, this.carriers, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Approach.des(JObject json) {
    List<Carrier> carriers = <Carrier>[];
    int id = json.get('id');
    int status = json.get('status');
    String email = json.get('email');
    DateTime timestamp = json.get('timestamp');
    String? enterprise = json.getDefault('enterprise', null);
    String? personal = json.getDefault('personal', null);
    String? alternative = json.getDefault('alternative', null);

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    List<JObject> rawCarriersArray = json.getList('Carriers');
    carriers = rawCarriersArray.map<Carrier>((JObject e) => deserealize(e, decode: CarrierDecoder())).toList();
    
    return Approach(id, status, email, enterprise, personal, alternative, statusNavigation, carriers, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kEmail: email,
      kEnterprise: enterprise,
      kPersonal: personal,
      kAlternative: alternative,
      kstatusNavigation: statusNavigation?.encode(),
      kTimestamp: timestamp.toIso8601String(),
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
  Approach.def();

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
    return Approach(id ?? this.id, status ?? this.status, email ?? this.email, enterprise ?? this.enterprise, personal ?? this.personal, alternative ?? this.alternative, statusNavigation ?? this.statusNavigation, carriers ?? this.carriers);
  }
  
}

final class ApproachDecoder implements CSMDecodeInterface<Approach> {
  const ApproachDecoder();

  @override
  Approach decode(JObject json) {
    return Approach.des(json);
  }
}
