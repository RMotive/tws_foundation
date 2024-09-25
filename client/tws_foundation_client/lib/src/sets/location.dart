import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Location implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kAddress = "address";
  static const String kName = "name";
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int address = 0;
  String name = "";
  Status? statusNavigation;

  Location(this.id, this.status, this.address, this.name, this.statusNavigation);
  factory Location.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int address = json.get('address');
    String name = json.get('name');    

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    return Location(id, status, address, name, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kName: name,
      kStatus: status,
      kAddress: address,
      kstatusNavigation: statusNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.isEmpty || name.length > 30) results.add(CSMSetValidationResult(kName, "Name must be 25 max lenght and non-empty", "strictLength(1,30)"));
    if(address < 0) results.add(CSMSetValidationResult(kAddress, 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Location.def();
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

final class LocationDecoder implements CSMDecodeInterface<Location> {
  const LocationDecoder();

  @override
  Location decode(JObject json) {
    return Location.des(json);
  }
}
