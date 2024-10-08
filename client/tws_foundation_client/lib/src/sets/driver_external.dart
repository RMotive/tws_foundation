import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverExternal implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kIdentification = "identification";
  static const String kCommon = "common";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kTimestamp = "timestamp";
  static const String kDriverCommonNavigation = 'DriverCommonNavigation';
  static const String kIdentificationNavigatorNavigation = 'IdentificationNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;
  
  @override
  int id = 0;
  int status = 1;
  int identification = 0;
  int common = 0;
  DriverCommon? driverCommonNavigation;
  Identification? identificationNavigation;
  Status? statusNavigation;

  DriverExternal(this.id, this.status, this.identification, this.common, this.driverCommonNavigation, this.identificationNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory DriverExternal.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int identification = json.get('identification');
    int common = json.get('identification');
    DateTime timestamp = json.get('timestamp');

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    DriverCommon? driverCommonNavigation;
    if (json['DriverCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverCommonNavigation', <String, dynamic>{});
      driverCommonNavigation = deserealize<DriverCommon>(rawNavigation, decode: DriverCommonDecoder());
    }

    Identification? identificationNavigator;
    if (json['IdentificationNavigation'] != null) {
      JObject rawNavigation = json.getDefault('IdentificationNavigation', <String, dynamic>{});
      identificationNavigator = deserealize<Identification>(rawNavigation, decode: IdentificationDecoder());
    }
        
    return DriverExternal(id, status, identification, common, driverCommonNavigation, identificationNavigator, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kIdentification: identification,
      kCommon: common,
      kTimestamp: timestamp.toIso8601String(),
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kIdentificationNavigatorNavigation: identificationNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identification <= 0 && identificationNavigation == null) results.add(CSMSetValidationResult(kIdentification, 'Debe ingresar el nombre y apellido del conductor externo. Identification pointer must be equal or greater than 0', 'pointerHandler()'));
    if(common <= 0 && driverCommonNavigation == null) results.add(CSMSetValidationResult(kCommon, 'Debe ingresar los datos comunes del conductor externo. Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(driverCommonNavigation != null) results = <CSMSetValidationResult>[...results, ...driverCommonNavigation!.evaluate()];   
    if(identificationNavigation != null) results = <CSMSetValidationResult>[...results, ...identificationNavigation!.evaluate()];   

    return results;
  }
  DriverExternal.def();
  DriverExternal clone({
    int? id,
    int? status,
    int? identification,
    int? common,
    Identification? identificationNavigation,
    DriverCommon? driverCommonNavigation,
    Status? statusNavigation,
  }){
    return DriverExternal(id ?? this.id, status ?? this.status, identification ?? this.identification, common ?? this.common, driverCommonNavigation ?? this.driverCommonNavigation, identificationNavigation ?? this.identificationNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class DriverExternalDecoder implements CSMDecodeInterface<DriverExternal> {
  const DriverExternalDecoder();

  @override
  DriverExternal decode(JObject json) {
    return DriverExternal.des(json);
  }
}
