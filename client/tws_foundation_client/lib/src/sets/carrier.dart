import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Carrier implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kDescription = "description";
  static const String kApproach = "approach";
  static const String kAddress = "address";
  static const String kUsdot = "usdot";
  static const String kTimestamp = "timestamp";
  static const String kStatusNavigation = 'StatusNavigation';
  static const String kApproachNavigation = "ApproachNavigation";
  static const String kAddressNavigation = "AddressNavigation";
  static const String kUsdotNavigation = "UsdotNavigation";
  static const String kTrucks = "trucks";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  @override
  int id = 0;
  int status = 1;
  int approach = 0;
  int address = 0;
  String name = "";
  String? description;
  int? usdot = 0;
  Approach? approachNavigation;
  Address? addressNavigation;
  USDOT? usdotNavigation;
  Status? statusNavigation;
  
  List<Truck> trucks = <Truck>[];

  Carrier(this.id, this.status, this.approach, this.address, this.name, this.description, this.usdot, this.approachNavigation, 
  this.addressNavigation, this.usdotNavigation, this.statusNavigation, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  factory Carrier.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    int status = json.get('status');
    int approach = json.get('approach');
    int address = json.get('address');
    String name = json.get('name');
    DateTime timestamp = json.get('timestamp');
    String? description = json.getDefault('description', null);
    int? usdot = json.getDefault('usdot', null);

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    Approach? approachNavigation;
    if (json['ApproachNavigation'] != null) {
      JObject rawNavigation = json.getDefault('ApproachNavigation', <String, dynamic>{});
      approachNavigation = deserealize<Approach>(rawNavigation, decode: ApproachDecoder());
    }

     Address? addressNavigation;
    if (json['addressNavigation'] != null) {
      JObject rawNavigation = json.getDefault('addressNavigation', <String, dynamic>{});
      addressNavigation = deserealize<Address>(rawNavigation, decode: AddressDecoder());
    }

     USDOT? usdotNavigation;
    if (json['UsdotNavigation'] != null) {
      JObject rawNavigation = json.getDefault('UsdotNavigation', <String, dynamic>{});
      usdotNavigation = deserealize<USDOT>(rawNavigation, decode: USDOTDecoder());
    }

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
    return Carrier(id, status, approach, address, name, description, usdot, approachNavigation, addressNavigation, usdotNavigation, statusNavigation, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kApproach: approach,
      kAddress: address,
      kName: name,
      kDescription: description,
      kUsdot: usdot,
      kStatusNavigation: statusNavigation?.encode(),
      kApproachNavigation: approachNavigation?.encode(),
      kAddressNavigation: addressNavigation?.encode(),
      kUsdotNavigation: usdotNavigation?.encode(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.length > 20) results.add(CSMSetValidationResult(kName, "Name must be 20 max length", "structLength(20)"));
    if(approach <= 0 && approachNavigation == null) results.add(CSMSetValidationResult("[$kApproach, $kApproachNavigation]", 'Required approach object. Must be at least one approach insertion property', 'requiredInsertion()'));
    if(address <= 0 && addressNavigation == null) results.add(CSMSetValidationResult("[$address, $addressNavigation]", 'Required address object. Must be at least one address insertion property', 'requiredInsertion()'));
    if(usdot != null && usdot! < 0) results.add(CSMSetValidationResult(kUsdot, 'USDOT pointer must be equal or greater than 0', 'pointerHandler()'));

    if(approachNavigation != null && approach != 0 && (approach != approachNavigation!.id)) results.add(CSMSetValidationResult("[$kApproach, $kApproachNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    if(addressNavigation != null && address != 0 && (address != addressNavigation!.id)) results.add(CSMSetValidationResult("[$kAddress, $kAddressNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));

    if(usdot != null && usdotNavigation != null){
      if(usdot != 0 && (usdotNavigation!.id != usdot)) results.add(CSMSetValidationResult("[$kUsdot, $usdotNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if(approachNavigation != null) results = <CSMSetValidationResult>[...results, ...approachNavigation!.evaluate()];
    if(addressNavigation != null) results = <CSMSetValidationResult>[...results, ...addressNavigation!.evaluate()]; 
    if(usdotNavigation != null) results = <CSMSetValidationResult>[...results, ...usdotNavigation!.evaluate()];
    return results;
  }

  Carrier.def();
  Carrier clone({
    int? id,
    int? status,
    int? approach,
    int? address,
    String? name,
    String? description,
    int? usdot,
    Status? statusNavigation,
    Approach? approachNavigation,
    Address? addressNavigation,
    USDOT? usdotNavigation,

    List<Truck>? trucks
  }){
    return Carrier(id ?? this.id, status ?? this.status, approach ?? this.approach, address ?? this.address, name ?? this.name, description ?? this.description, usdot ?? this.usdot, 
    approachNavigation ?? this.approachNavigation, addressNavigation ?? this.addressNavigation, usdotNavigation ?? this.usdotNavigation, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
}

final class CarrierDecoder implements CSMDecodeInterface<Carrier> {
  const CarrierDecoder();

  @override
  Carrier decode(JObject json) {
    return Carrier.des(json);
  }
}
