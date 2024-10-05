import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Trailer implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kModel = "model";
  static const String kCarrier = "carrier";
  static const String kMaintenance = "maintenance";
  static const String kTimestamp = "timestamp";
  static const String kVehiculeModelNavigation = "VehiculeModelNavigation";
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';
  static const String kCarrierNavigation = "CarrierNavigation";
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kPlates = 'plates';

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  int status = 1;
  int common = 0;
  int carrier = 0;
  int? model;
  int? maintenance;
  Carrier? carrierNavigation;
  TrailerCommon? trailerCommonNavigation;
  VehiculeModel? vehiculeModelNavigation;
  Status? statusNavigation;
  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[
    Plate.def(),
    Plate.def()
  ];
  Trailer(this.id, this.status, this.common, this.carrier, this.model, this.maintenance, this.carrierNavigation, this.trailerCommonNavigation, this.vehiculeModelNavigation, this.statusNavigation, this.plates, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  factory Trailer.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    DateTime timestamp = json.get('timestamp');
    int carrier = json.get('carrier');
    int? model = json.getDefault('model', null);
    int? maintenance = json.getDefault('situation', null);
  
    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList('Plates');
    plates = rawPlateArray.map<Plate>((JObject e) => deserealize(e, decode: PlateDecoder())).toList();

    TrailerCommon? trailerCommonNavigation;
    if (json['TrailerCommonNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerCommonNavigation', <String, dynamic>{});
      trailerCommonNavigation = deserealize<TrailerCommon>(rawNavigation, decode: TrailerCommonDecoder());
    }

    Status? statusNavigation;
    if (json['StatusNavigation'] != null) {
      JObject rawNavigation = json.getDefault('StatusNavigation', <String, dynamic>{});
      statusNavigation = deserealize<Status>(rawNavigation, decode: StatusDecoder());
    }

    VehiculeModel? vehiculeModelNavigation;
    if (json['VehiculeModelNavigation'] != null) {
      JObject rawNavigation = json.getDefault('VehiculeModelNavigation', <String, dynamic>{});
      vehiculeModelNavigation = deserealize<VehiculeModel>(rawNavigation, decode: VehiculeModelDecoder());
    }

    Carrier? carrierNavigation;
    if (json['CarrierNavigation'] != null) {
      JObject rawNavigation = json.getDefault('CarrierNavigation', <String, dynamic>{});
      carrierNavigation = deserealize<Carrier>(rawNavigation, decode: CarrierDecoder());
    }

    return Trailer(id, status, common, carrier, model, maintenance, carrierNavigation, trailerCommonNavigation, vehiculeModelNavigation, statusNavigation, plates, timestamp: timestamp);
  }

  @override
  JObject encode() {
    // Avoiding EF tracking issues.
    JObject? carrierNav = carrierNavigation?.encode();
    if(carrier != 0) carrierNav = null;
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kCarrier: carrier,
      kModel: model,
      kMaintenance: maintenance,
      kTimestamp: timestamp.toIso8601String(),
      kCarrierNavigation: carrierNav,
      kVehiculeModelNavigation: vehiculeModelNavigation?.encode(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(plates.isEmpty) results.add(CSMSetValidationResult(kPlates, 'Trailer must have 1 plate at least', 'listLength()'));
    for(Plate plate in plates){
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }
    if(trailerCommonNavigation != null){
      results = <CSMSetValidationResult>[...results, ...trailerCommonNavigation!.evaluate()];
    }

    if(vehiculeModelNavigation != null){
      results = <CSMSetValidationResult>[...results, ...vehiculeModelNavigation!.evaluate()];
    }

    if(carrierNavigation != null){
      results = <CSMSetValidationResult>[...results, ...carrierNavigation!.evaluate()];
    }

    return results;
  }
  Trailer.def();
  Trailer clone({
    int? id,
    int? status,
    int? common,
    int? carrier,
    int? model,
    int? maintenance,
    Carrier? carrierNavigation,
    TrailerCommon? trailerCommonNavigation,
    VehiculeModel? vehiculeModelNavigation,
    Status? statusNavigation,
    List<Plate>? plates
  }){
    Carrier? carrierNav = carrierNavigation ?? this.carrierNavigation;
    if((carrier ?? this.carrier) == 0) carrierNav = null;

    return Trailer(id ?? this.id, status ?? this.status, common ?? this.common, carrier ?? this.carrier, model ?? this.model, maintenance ?? this.maintenance, carrierNav,
    trailerCommonNavigation ?? this.trailerCommonNavigation,  vehiculeModelNavigation ?? this.vehiculeModelNavigation, statusNavigation ?? this.statusNavigation, plates ?? this.plates);
  }
}

final class TrailerDecoder implements CSMDecodeInterface<Trailer> {
  const TrailerDecoder();

  @override
  Trailer decode(JObject json) {
    return Trailer.des(json);
  }
}
