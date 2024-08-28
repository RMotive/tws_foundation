import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailerCommon implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kTrailerClass = "class";
  static const String kCarrier = "carrier";
  static const String kSituation = "situation";
  static const String kLocation = "location";
  static const String kEconomic = "economic";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kPlates = 'plates';

  @override
  int id = 0;
  int status = 0;
  int trailerClass = 0;
  int carrier = 0;
  int situation = 0;
  int? location;
  String economic = "";
  Status? statusNavigation;
  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[
    Plate.def(),
    Plate.def()
  ];
  TrailerCommon(this.id, this.status, this.trailerClass, this.carrier, this.situation, this.location, this.economic, this.statusNavigation, this.plates);
  factory TrailerCommon.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int trailerClass = json.get('class');
    int carrier = json.get('carrier');
    int situation = json.get('situation');
    int? location = json.getDefault('location', null);
    String economic = json.get('economic');

    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList('Plates');
    plates = rawPlateArray.map<Plate>((JObject e) => deserealize(e, decode: PlateDecoder())).toList();

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }
        
    return TrailerCommon(id, status, trailerClass, carrier, situation, location, economic, statusNavigation, plates);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kTrailerClass: trailerClass,
      kCarrier: carrier,
      kSituation: situation,
      kLocation: location,
      kEconomic: economic,
      kstatusNavigation: statusNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(economic.length < 8 || economic.length > 12) results.add(CSMSetValidationResult(kEconomic, "Economic number length must be between 1 and 16", "strictLength(1,16)"));
    if(trailerClass < 0) results.add(CSMSetValidationResult(kTrailerClass, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if(situation < 0) results.add(CSMSetValidationResult(kSituation, 'Situation pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(plates.length != 2) results.add(CSMSetValidationResult(kPlates, 'Plates list must contain 2 objects', 'listLength(2)'));
    for(Plate plate in plates){
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }
    return results;
  }
  TrailerCommon.def();
  TrailerCommon clone({
    int? id,
    int? status,
    int? trailerClass,
    int? carrier,
    int? situation,
    int? location,
    String? economic,
    Status? statusNavigation,
    List<Plate>? plates
  }){
    return TrailerCommon(id ?? this.id, status ?? this.status, trailerClass ?? this.trailerClass, carrier ?? this.carrier, situation ?? this.situation, location ?? this.location,
    economic ?? this.economic, statusNavigation ?? this.statusNavigation, plates ?? this.plates
    );
  }
}

final class TrailerCommonDecoder implements CSMDecodeInterface<TrailerCommon> {
  const TrailerCommonDecoder();

  @override
  TrailerCommon decode(JObject json) {
    return TrailerCommon.des(json);
  }
}
