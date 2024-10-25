import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SCT implements CSMSetInterface {
   /// [type] property key.
  static const String kType = "type";

  /// [number] property key.
  static const String kNumber = "number";

  /// [configuration] property key.
  static const String kConfiguration = "configuration";

  /// [trucks] property key.
  static const String kTrucks = "trucks";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreing relation [Status] pointer.
  int status = 1;

  /// Descriptive type of permit.
  String type = "";

  /// Identification number of permit.
  String number = "";

  /// Descriptive permit configuration.
  String configuration = "";

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// Creates a [SCT] object with required properties.
  SCT(this.id, this.status, this.type, this.number, this.configuration, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates a [SCT] object with default properties.
  SCT.a();

  factory SCT.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String type = json.get(kType);
    String number = json.get(kNumber);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String configuration = json.get(kConfiguration);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    
    return SCT(id, status, type, number, configuration, statusNavigation, timestamp: timestamp);
  }

  /// Creates a [SCT] object overriding given properties.
  SCT clone({
    int? id,
    int? status,
    String? type,
    String? number,
    String? configuration,
    Status? statusNavigation,
  }){
    return SCT(
      id ?? this.id, 
      status ?? this.status, 
      type ?? this.type, 
      number ?? this.number, 
      configuration ?? this.configuration, 
      statusNavigation ?? this.statusNavigation
    );
  }


  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kType: type,
      kNumber: number,
      kConfiguration: configuration,
      SCK.kTimestamp: timestamp.toIso8601String(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(type.length != 6) results.add(CSMSetValidationResult(kType, "Type must be 6 length", "strictLength(6)"));
    if(number.length != 25) results.add(CSMSetValidationResult(kNumber, "Number must be 25 length", "structLength(25)"));
    if(configuration.length < 6 || configuration.length > 10) results.add(CSMSetValidationResult(kConfiguration, "Configuration must be between 6 and 10 length", "strictLength(6,10)"));
    
    return results;
  } 
}
