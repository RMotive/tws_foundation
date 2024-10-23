import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';


/// Third party transportists enterprise relation inforamtion, handles information of
/// third party enterprises that provides transportists and relation between activities.
final class Carrier implements CSMSetInterface {
 /// [status] property key.
  static const String kStatus = "status";

  /// [approach] property key.
  static const String kApproach = "approach";

  /// [address] property key.
  static const String kAddress = "address";

  /// [usdot] property key.
  static const String kUsdot = "usdot";

  /// [statusNavigation] property key.
  static const String kStatusNavigation = 'StatusNavigation';

  /// [approachNavigation] property key.
  static const String kApproachNavigation = "ApproachNavigation";

  /// [addressNavigation] property key.
  static const String kAddressNavigation = "AddressNavigation";

  /// [usdotNavigation] property key.
  static const String kUsdotNavigation = "UsdotNavigation";

  /// [sctNavigation] property key.
  static const String kSctNavigation = "SctNavigation";

  /// [trucks] property key.
  static const String kTrucks = "trucks";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  
  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Foreign relation [Approach] pointer.
  int approach = 0;

  /// Foreign relation [Address] pointer.
  int address = 0;

  /// Carrier name.
  String name = "";

  /// Carrier description.
  String? description;

  /// Foreign relation [USDOT] pointer.
  int? usdot = 0;

  /// Foreign relation [Approach] object.
  Approach? approachNavigation;

  /// Foreign relation [Address] object.
  Address? addressNavigation;

  /// Foreign relation [USDOT] object.
  USDOT? usdotNavigation;
  
  /// Foregin relation [Status] object.
  Status? statusNavigation;

  /// List of [Truck]s belongs to the current [Carrier].
  List<Truck> trucks = <Truck>[];

  /// Creates a [Carrier] object with required properties.
  Carrier(this.id, this.status, this.approach, this.address, this.name, this.description, this.usdot, this.approachNavigation, 
  this.addressNavigation, this.usdotNavigation, this.statusNavigation, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  factory Carrier.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int approach = json.get(kApproach);
    int address = json.get(kAddress);
    String name = json.get(SCK.kName);
    DateTime timestamp = json.get(SCK.kTimestamp);
    String? description = json.getDefault(SCK.kDescription, null);
    int? usdot = json.getDefault(kUsdot, null);

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Approach? approachNavigation;
    if (json[kApproachNavigation] != null) {
      JObject rawNavigation = json.getDefault(kApproachNavigation, <String, dynamic>{});
      approachNavigation = Approach.des(rawNavigation);
    }

     Address? addressNavigation;
    if (json[kAddressNavigation] != null) {
      JObject rawNavigation = json.getDefault(kAddressNavigation, <String, dynamic>{});
      addressNavigation = Address.des(rawNavigation);
    }

     USDOT? usdotNavigation;
    if (json[kUsdotNavigation] != null) {
      JObject rawNavigation = json.getDefault(kUsdotNavigation, <String, dynamic>{});
      usdotNavigation = USDOT.des(rawNavigation);
    }

    List<JObject> rawTrucksArray = json.getList('Trucks');
    trucks = rawTrucksArray.map<Truck>(Truck.des).toList();
    
    return Carrier(id, status, approach, address, name, description, usdot, approachNavigation, addressNavigation, usdotNavigation, statusNavigation, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kApproach: approach,
      kAddress: address,
      SCK.kName: name,
      SCK.kDescription: description,
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
    if(name.length > 20) results.add(CSMSetValidationResult(SCK.kName, "Name must be 20 max length", "structLength(20)"));
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

