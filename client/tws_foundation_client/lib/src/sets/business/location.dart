import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Location implements CSMSetInterface {
  static const String kAddress = "address";
  static const String kstatusNavigation = 'StatusNavigation';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int address = 0;
  String name = "";
  Status? statusNavigation;

  Location(this.id, this.status, this.address, this.name, this.statusNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  Location.a();
  
  factory Location.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int address = json.get(kAddress);
    String name = json.get(SCK.kName);    
    DateTime timestamp = json.get(SCK.kTimestamp);

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    return Location(id, status, address, name, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      SCK.kName: name,
      SCK.kStatus: status,
      kAddress: address,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(SCK.kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(address < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Location clone({
    int? id,
    int? status,
    int? address,
    String? name,
    Status? statusNavigation,
  }){
   
    return Location(id ?? this.id, status ?? this.status, address ?? this.address, name ?? this.name, statusNavigation ?? this.statusNavigation);
  }

}