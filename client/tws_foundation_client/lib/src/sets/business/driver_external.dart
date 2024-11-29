import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class DriverExternal implements CSMSetInterface {

  /// [Identification] property key.
  static const String kIdentification = "identification";

  /// [common] property key.
  static const String kCommon = "common";

  /// [DriverCommon] property key.
  static const String kDriverCommonNavigation = 'DriverCommonNavigation';

  /// [identificationNavigation] property key.
  static const String kIdentificationNavigation = 'IdentificationNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign  relation [Status] key.
  int status = 1;

  /// Foreign relation [Identification] key.
  int identification = 0;

  /// Foreign relation [DriverCommon] key.
  int common = 0;

  /// [DriverCommon] Navigation set. 
  DriverCommon? driverCommonNavigation;

  /// [Identification] Navigation set.
  Identification? identificationNavigation;

  /// [Status] Navigation set.
  Status? statusNavigation;

  /// Creates an [DriverExternal] object with default values.
  DriverExternal.a(){
    _timestamp = DateTime.now();
  }

  /// Creates an [DriverExternal] object with requiered properties.
  DriverExternal(this.id, this.status, this.identification, this.common, this.driverCommonNavigation, this.identificationNavigation, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [DriverExternal] object based on a serialized json object.
  factory DriverExternal.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int identification = json.get(kIdentification);
    int common = json.get(kCommon);
    DateTime timestamp = json.get(SCK.kTimestamp);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    DriverCommon? driverCommonNavigation;
    if (json[kDriverCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kDriverCommonNavigation, <String, dynamic>{});
      driverCommonNavigation = DriverCommon.des(rawNavigation);
    }


   Identification? identificationNavigator;
    if (json[kIdentificationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kIdentificationNavigation, <String, dynamic>{});
      identificationNavigator = Identification.des(rawNavigation);
    }
        
    return DriverExternal(id, status, identification, common, driverCommonNavigation, identificationNavigator, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kIdentification: identification,
      kCommon: common,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kDriverCommonNavigation: driverCommonNavigation?.encode(),
      kIdentificationNavigation: identificationNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(identification <= 0 && identificationNavigation == null) results.add(CSMSetValidationResult(kIdentification, 'Debe ingresar el nombre y apellido del conductor externo. Identification pointer must be equal or greater than 0', 'pointerHandler()'));
    if(common <= 0 && driverCommonNavigation == null) results.add(CSMSetValidationResult(kCommon, 'Debe ingresar los datos comunes del conductor externo. Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(driverCommonNavigation != null) results = <CSMSetValidationResult>[...results, ...driverCommonNavigation!.evaluate()];   
    if(identificationNavigation != null) results = <CSMSetValidationResult>[...results, ...identificationNavigation!.evaluate()];   

    return results;
  }

  /// Creates a clone for a [DriverExternal] object, overriding the given values.
  DriverExternal clone({
    int? id,
    int? status,
    int? identification,
    int? common,
    Identification? identificationNavigation,
    DriverCommon? driverCommonNavigation,
    Status? statusNavigation,
  }){

    if (identification == 0) {
      this.identificationNavigation = null;
      identificationNavigation = null;
    }
 
    return DriverExternal(id ?? this.id, status ?? this.status, identification ?? this.identification, common ?? this.common, driverCommonNavigation ?? this.driverCommonNavigation, identificationNavigation ?? this.identificationNavigation, statusNavigation ?? this.statusNavigation);
  }
}

