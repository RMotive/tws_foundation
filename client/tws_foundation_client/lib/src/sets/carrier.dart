import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Carrier implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kName = "name";
  static const String kDescription = "description";
  static const String kApproach = "approach";
  static const String kAddress = "address";
  static const String kUsdot = "usdot";
  static const String kSct = "sct";
  static const String kStatusNavigation = 'StatusNavigation';
  static const String kApproachNavigation = "ApproachNavigation";
  static const String kAddressNavigation = "AddressNavigation";
  static const String kUsdotNavigation = "UsdotNavigation";
  static const String kSctNavigation = "SctNavigation";
  static const String kTrucks = "trucks";


  @override
  int id = 0;
  int status = 1;
  int approach = 0;
  int address = 0;
  String name = "";
  String? description;
  int? usdot = 0;
  int? sct = 0;
  Approach? approachNavigation;
  Address? addressNavigation;
  USDOT? usdotNavigation;
  SCT? sctNavigation;
  Status? statusNavigation;
  
  List<Truck> trucks = <Truck>[];

  Carrier(this.id, this.status, this.approach, this.address, this.name, this.description, this.usdot, this.sct, this.approachNavigation, this.addressNavigation, this.usdotNavigation, this.sctNavigation, this.statusNavigation, this.trucks);
  factory Carrier.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get('id');
    int status = json.get('status');
    int approach = json.get('approach');
    int address = json.get('address');
    String name = json.get('name');
    String? description = json.getDefault('description', null);
    int? usdot = json.getDefault('usdot', null);
    int? sct = json.getDefault('sct', null);

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

     SCT? sctNavigation;
    if (json['SctNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SctNavigation', <String, dynamic>{});
      sctNavigation = deserealize<SCT>(rawNavigation, decode: SCTDecoder());
    }

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>((JObject e) => deserealize(e, decode: TruckDecoder())).toList();
    
    return Carrier(id, status, approach, address, name, description, usdot, sct, approachNavigation, addressNavigation, usdotNavigation, sctNavigation, statusNavigation, trucks);
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
      kSct: sct,
      kStatusNavigation: statusNavigation?.encode(),
      kApproachNavigation: approachNavigation?.encode(),
      kAddressNavigation: addressNavigation?.encode(),
      kUsdotNavigation: addressNavigation?.encode(),
      kSctNavigation: sctNavigation?.encode(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(name.length > 20) results.add(CSMSetValidationResult(kName, "Name must be 20 max length", "structLength(20)"));
    if(approach <= 0 && approachNavigation == null) results.add(CSMSetValidationResult("[$kApproach, $kApproachNavigation]", 'Required approach object. Must be at least one approach insertion property', 'requiredInsertion()'));
    if(address <= 0 && addressNavigation == null) results.add(CSMSetValidationResult("[$address, $addressNavigation]", 'Required address object. Must be at least one address insertion property', 'requiredInsertion()'));
    if(sct != null && sct! < 0) results.add(CSMSetValidationResult(kSct, 'SCT pointer must be equal or greater than 0', 'pointerHandler()'));
    if(usdot != null && usdot! < 0) results.add(CSMSetValidationResult(kUsdot, 'USDOT pointer must be equal or greater than 0', 'pointerHandler()'));

    if(approachNavigation != null && approach != 0 && (approach != approachNavigation!.id)) results.add(CSMSetValidationResult("[$kApproach, $kApproachNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    if(addressNavigation != null && address != 0 && (address != addressNavigation!.id)) results.add(CSMSetValidationResult("[$kAddress, $kAddressNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));

    if(sct != null && sctNavigation != null){
      if(sct != 0 && (sctNavigation!.id != sct)) results.add(CSMSetValidationResult("[$kSct, $kSctNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if(usdot != null && usdotNavigation != null){
      if(usdot != 0 && (usdotNavigation!.id != usdot)) results.add(CSMSetValidationResult("[$kUsdot, $usdotNavigation]", 'if pointer property and navegation property is not null, the pointers for both must be the same, and navegation data must be the same that the stored in data source.', 'insertionConflict()'));
    } 

    if((usdot == null && usdotNavigation == null) && (sct == null && sctNavigation == null)) results.add(CSMSetValidationResult("[$usdot, $sct]", 'Missing pointers. at least SCT or USDOT property must be set', 'missingProperty()'));
    if(approachNavigation != null) results = <CSMSetValidationResult>[...results, ...approachNavigation!.evaluate()];
    if(addressNavigation != null) results = <CSMSetValidationResult>[...results, ...addressNavigation!.evaluate()]; 
    if(usdotNavigation != null) results = <CSMSetValidationResult>[...results, ...usdotNavigation!.evaluate()];
    if(sctNavigation != null) results = <CSMSetValidationResult>[...results, ...sctNavigation!.evaluate()];   
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
    int? sct,
    Status? statusNavigation,
    Approach? approachNavigation,
    Address? addressNavigation,
    USDOT? usdotNavigation,
    SCT? sctNavigation,

    List<Truck>? trucks
  }){
    return Carrier(id ?? this.id, status ?? this.status, approach ?? this.approach, address ?? this.address, name ?? this.name, description ?? this.description, usdot ?? this.usdot, sct ?? this.sct, approachNavigation ?? this.approachNavigation, addressNavigation ?? this.addressNavigation, usdotNavigation ?? this.usdotNavigation, sctNavigation ?? this.sctNavigation, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
}

final class CarrierDecoder implements CSMDecodeInterface<Carrier> {
  const CarrierDecoder();

  @override
  Carrier decode(JObject json) {
    return Carrier.des(json);
  }
}
