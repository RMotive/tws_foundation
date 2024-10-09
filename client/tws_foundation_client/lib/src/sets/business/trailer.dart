import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Trailer implements CSMSetInterface {
  static const String kCommon = "common";
  static const String kModel = "model";
  static const String kCarrier = "carrier";
  static const String kMaintenance = "maintenance";
  static const String kVehiculeModelNavigation = "VehiculeModelNavigation";
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';
  static const String kCarrierNavigation = "CarrierNavigation";
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
    int id = json.get(SCK.kId);
    int status = json.get(SCK.kStatus);
    int common = json.get(kCommon);
    DateTime timestamp = json.get(SCK.kTimestamp);
    int carrier = json.get(kCarrier);
    int? model = json.getDefault(kModel, null);
    int? maintenance = json.getDefault(kMaintenance, null);
  
    List<Plate> plates = <Plate>[];
    List<JObject> rawPlateArray = json.getList(kPlates);
    plates = rawPlateArray.map<Plate>(Plate.des).toList();

    TrailerCommon? trailerCommonNavigation;
    if (json[kTrailerCommonNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTrailerCommonNavigation, <String, dynamic>{});
      trailerCommonNavigation = TrailerCommon.des(rawNavigation);
    }

    Status? statusNavigation;
    if (json[SCK.kStatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(SCK.kStatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }

    VehiculeModel? vehiculeModelNavigation;
    if (json[kVehiculeModelNavigation] != null) {
      JObject rawNavigation = json.getDefault(kVehiculeModelNavigation, <String, dynamic>{});
      vehiculeModelNavigation = VehiculeModel.des(rawNavigation);
    }

    Carrier? carrierNavigation;
    if (json[kCarrierNavigation] != null) {
      JObject rawNavigation = json.getDefault(kCarrierNavigation, <String, dynamic>{});
      carrierNavigation = Carrier.des(rawNavigation);
    }

    return Trailer(id, status, common, carrier, model, maintenance, carrierNavigation, trailerCommonNavigation, vehiculeModelNavigation, statusNavigation, plates, timestamp: timestamp);
  }

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

  @override
  JObject encode() {
    // Avoiding EF tracking issues.
    JObject? carrierNav = carrierNavigation?.encode();
    if(carrier != 0) carrierNav = null;
    return <String, dynamic>{
      SCK.kId: id,
      SCK.kStatus: status,
      kCommon: common,
      kCarrier: carrier,
      kModel: model,
      kMaintenance: maintenance,
      SCK.kTimestamp: timestamp.toIso8601String(),
      kCarrierNavigation: carrierNav,
      kVehiculeModelNavigation: vehiculeModelNavigation?.encode(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      SCK.kStatusNavigation: statusNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(SCK.kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
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
  
}

