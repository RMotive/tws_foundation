import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckCommon implements CSMSetInterface {
  /// [status] property key.
  static const String kStatus = "status";

  /// [economic] property key.
  static const String kEconomic = "economic";

  /// [location] property key.
  static const String kLocation = "location";

  /// [situation] property key.
  static const String kSituation = "situation";

  /// [statusNavigation] property key.
  static const String kstatusNavigation = 'StatusNavigation';

  /// [situationNavigation] property key.
  static const String kSituationNavigation = 'SituationNavigation';
  
  /// [locationNavigation] property key.
  static const String kLocationNavigation = 'LocationNavigation';

  //Private timestamp property
  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 


  /// Record database pointer.
  @override
  int id = 0;

  /// Foreign relation [Status] pointer.
  int status = 1;

  /// [Truck] economic label identification.
  String economic = "";

  /// Foreign relation [Location] pointer.
  int? location;

  /// Foreign relation [Situation] pointer.
  int? situation;

  /// Foreign relation [Situation] object.
  Situation? situationNavigation;

  /// Foreign relation [Location] object.
  Location? locationNavigation;

  /// Foreign relation [Status] object.
  Status? statusNavigation;
  
  /// Creates a [TruckCommon] object with default properties.
  TruckCommon.a();

  TruckCommon(this.id, this.status, this.economic, this.location, this.situation, this.situationNavigation, this.locationNavigation, this.statusNavigation, {
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  factory TruckCommon.des(JObject json) {
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    String economic = json.get(kEconomic);
    int? location = json.getDefault(kLocation, null);
    int? situation = json.getDefault(kSituation, null);
    DateTime timestamp = json.get(SCK.kTimestamp);
    
    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    Situation? situationNavigation;
    if (json[kSituationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSituationNavigation, <String, dynamic>{});
      situationNavigation = Situation.des(rawNavigation);
    }

    Location? locationNavigation;
    if (json[kLocationNavigation] != null) {
      JObject rawNavigation = json.getDefault(kLocationNavigation, <String, dynamic>{});
      locationNavigation = Location.des(rawNavigation);
    }
        
    return TruckCommon(id, status, economic, location, situation, situationNavigation, locationNavigation, statusNavigation, timestamp: timestamp);
  }

  @override
  JObject encode() {
     // Avoiding EF tracking issues.
    JObject? locationNav = locationNavigation?.encode();
    if(location != null && location != 0) locationNav = null;
    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kEconomic: economic,
      kLocation: location,
      kSituation: situation,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kSituationNavigation: situationNavigation?.encode(),
      kLocationNavigation: locationNav,
      SCK.kStatusNavigation: statusNavigation?.encode()
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.isEmpty || economic.length > 16) results.add(CSMSetValidationResult(kEconomic, "El numero economico no debe estar vacio y debe tener un maximo de 16 caracteres", "strictLength(1,16)"));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(location != null){
      if(location! < 0) results.add(CSMSetValidationResult(kLocation, 'Location pointer must be equal or greater than 0', 'pointerHandler()'));
    }
    if(situation != null){
      if(situation! < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    }

    if(locationNavigation != null) results = <CSMSetValidationResult>[...results, ...locationNavigation!.evaluate()];
    if(situationNavigation != null) results = <CSMSetValidationResult>[...results, ...situationNavigation!.evaluate()];


    return results;
  }
  TruckCommon clone({
    int? id,
    int? status,
    String? vin,
    String? economic,
    int? location,
    int? situation,
    Situation? situationNavigation,
    Location? locationNavigation,
    Status? statusNavigation,
  }){
    
    int? situationIndex = situation ?? this.situation;
    Situation? situationNav = situationNavigation ?? this.situationNavigation;
    if(situationIndex == 0){
      situationIndex = null;
      situationNav = null; 
    }

    int? locationIndex = location ?? this.location;
    Location? locationNav = locationNavigation ?? this.locationNavigation;
    if(locationIndex == 0){
      locationIndex = null;
      locationNav = null; 
    }

    return TruckCommon(
      id ?? this.id, 
      status ?? this.status, 
      economic ?? this.economic, 
      locationIndex, 
      situationIndex,
      situationNav, 
      locationNav 
      ,statusNavigation ?? this.statusNavigation
    );
  }
}

