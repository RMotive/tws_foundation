import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Trailer implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kCarrier = "carrier";
  static const String kManufacturer = "manufacturer";
  static const String kMaintenance = "maintenance";
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';
  static const String kstatusNavigation = 'StatusNavigation';
  static const String kPlates = 'plates';

  @override
  int id = 0;
  int status = 1;
  int common = 0;
  int carrier = 0;
  int manufacturer = 0;
  int? maintenance;
  TrailerCommon? trailerCommonNavigation;
  Status? statusNavigation;
  // List default initialization data for clone method.
  List<Plate> plates = <Plate>[
    Plate.def(),
    Plate.def()
  ];
  Trailer(this.id, this.status, this.common, this.carrier, this.manufacturer, this.maintenance, this.trailerCommonNavigation, this.statusNavigation, this.plates);
  factory Trailer.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    int carrier = json.get('carrier');
    int manufactuer = json.get('manufacturer');
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


    return Trailer(id, status, common, carrier, manufactuer, maintenance, trailerCommonNavigation, statusNavigation, plates);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kCarrier: carrier,
      kManufacturer: manufacturer,
      kMaintenance: maintenance,
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
      kPlates: plates.map((Plate i) => i.encode()).toList(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(manufacturer < 0) results.add(CSMSetValidationResult(kManufacturer, 'Manufacturer pointer must be equal or greater than 0', 'pointerHandler()'));
    if(carrier < 0) results.add(CSMSetValidationResult(kCarrier, 'Carrier pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));
    if(plates.length != 2) results.add(CSMSetValidationResult(kPlates, 'Plates list must contain 2 objects', 'listLength(2)'));
    for(Plate plate in plates){
      results = <CSMSetValidationResult>[...results, ...plate.evaluate()];
    }

    return results;
  }
  Trailer.def();
  Trailer clone({
    int? id,
    int? status,
    int? common,
    int? carrier,
    int? manufacturer,
    int? maintenance,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation,
    List<Plate>? plates
  }){
    return Trailer(id ?? this.id, status ?? this.status, common ?? this.common, carrier ?? this.carrier, manufacturer ?? this.manufacturer, maintenance ?? this.maintenance,
    trailerCommonNavigation ?? this.trailerCommonNavigation, statusNavigation ?? this.statusNavigation, plates ?? this.plates);
  }
}

final class TrailerDecoder implements CSMDecodeInterface<Trailer> {
  const TrailerDecoder();

  @override
  Trailer decode(JObject json) {
    return Trailer.des(json);
  }
}
