import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class USDOT implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kMc = "type";
  static const String kScac = "number";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  String mc = "";
  String scac = "";
  Status? statusNavigation;

  USDOT(this.id, this.status, this.mc, this.scac, this.statusNavigation);
  factory USDOT.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    String mc = json.get('mc');
    String scac = json.get('scac');
    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return USDOT(id, status, mc, scac, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kMc: mc,
      kScac: scac,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(mc.length != 7) results.add(CSMSetValidationResult(kMc, "MC number must be 7 length", "strictLength(7)"));
    if(scac.length != 4) results.add(CSMSetValidationResult(kScac, "SCAC number must be 4 length", "structLength(4)"));
    
    return results;
  }
  USDOT.def();
  USDOT clone({
    int? id,
    int? status,
    String? mc,
    String? scac,
    Status? statusNavigation,
  }){
    return USDOT(id ?? this.id, status ?? this.status, mc ?? this.mc, scac ?? this.scac, statusNavigation ?? this.statusNavigation);
  }
}

final class USDOTDecoder implements CSMDecodeInterface<USDOT> {
  const USDOTDecoder();

  @override
  USDOT decode(JObject json) {
    return USDOT.des(json);
  }
}
