import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Insurance implements CSMSetInterface {
  /// [policy] property key.
  static const String kPolicy = "policy";

  /// [expiration] property key.
  static const String kExpiration = "expiration";

  /// [country] property key.
  static const String kCountry = "country";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// [trucks] property key.
  static const String kTrucks = "trucks";


  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// Policy identification value.
  String policy = "";

  /// Expiration time.
  DateTime expiration = DateTime(2000);

  /// Source country.
  String country = "";

  /// Foreign relation [Status] object.
  Status? statusNavigation;

  /// List of [Truck]s have the current [Insurance].
  List<Truck> trucks = <Truck>[];

  /// Creates an [Insurance] object with required properties.
  Insurance(this.id, this.status, this.policy, this.expiration, this.country, this.statusNavigation, this.trucks, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [Insurance] object with default properties.
  Insurance.a();

  /// Creates an [Insurance] object based on a given [json] object.
  factory Insurance.des(JObject json) {
    List<Truck> trucks = <Truck>[];
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String policy = json.get(kPolicy);
    DateTime expiration = json.get(kExpiration);
    String country = json.get(kCountry);
    DateTime timestamp = json.get(SCK.kTimestamp);
    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    List<JObject> rawTrucksArray = json.getList(kTrucks);
    trucks = rawTrucksArray
      .map<Truck>(
        (JObject json) => Truck.des(json),
      )
      .toList();

    
    return Insurance(id, status, policy, expiration, country, statusNavigation, trucks, timestamp: timestamp);
  }

  @override
  JObject encode() {
    String e = expiration.toString().substring(0, 10);

    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kPolicy: policy,
      kExpiration: e,
      kCountry: country,
      kstatusNavigation: statusNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
      kTrucks: trucks.map((Truck i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(policy.length > 20) results.add(CSMSetValidationResult(kPolicy, "Policy must be 20 length", "strictLength(20)"));
    if(country.length<2 && country.length>3) results.add(CSMSetValidationResult(kCountry,"Country must be between 2 and 3 length", "strictLength(2,3)"));

    return results;
  }

  /// Creates an [Insurance] object overriding the given properties.
  Insurance clone({
    int? id,
    int? status,
    String? policy,
    DateTime? expiration,
    String? country,
    Status? statusNavigation,
    List<Truck>? trucks
  }){
    return Insurance(id ?? this.id, status ?? this.status, policy ?? this.policy, expiration ?? this.expiration, country ?? this.country, statusNavigation ?? this.statusNavigation, trucks ?? this.trucks);
  }
  
}

