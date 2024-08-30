import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Trailer implements CSMSetInterface {
  static const String kStatus = "status";
  static const String kCommon = "common";
  static const String kManufacturer = "manufacturer";
  static const String kMaintenance = "maintenance";
  static const String kTrailerCommonNavigation = 'TrailerCommonNavigation';
  static const String kstatusNavigation = 'StatusNavigation';

  @override
  int id = 0;
  int status = 1;
  int common = 0;
  int manufacturer = 0;
  int? maintenance;
  TrailerCommon? trailerCommonNavigation;
  Status? statusNavigation;

  Trailer(this.id, this.status, this.common, this.manufacturer, this.maintenance, this.trailerCommonNavigation, this.statusNavigation);
  factory Trailer.des(JObject json) {
    int id = json.get('id');
    int status = json.get('status');
    int common = json.get('common');
    int manufactuer = json.get('manufacturer');
    int? maintenance = json.getDefault('situation', null);

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


    return Trailer(id, status, common, manufactuer, maintenance, trailerCommonNavigation, statusNavigation);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kStatus: status,
      kCommon: common,
      kManufacturer: manufacturer,
      kMaintenance: maintenance,
      kTrailerCommonNavigation: trailerCommonNavigation?.encode(),
      kstatusNavigation: statusNavigation?.encode(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(common < 0) results.add(CSMSetValidationResult(kCommon, 'Common pointer must be equal or greater than 0', 'pointerHandler()'));
    if(manufacturer < 0) results.add(CSMSetValidationResult(kManufacturer, 'Manufacturer pointer must be equal or greater than 0', 'pointerHandler()'));
    if(status < 0) results.add(CSMSetValidationResult(kStatus, 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    return results;
  }
  Trailer.def();
  Trailer clone({
    int? id,
    int? status,
    int? common,
    int? manufacturer,
    int? maintenance,
    TrailerCommon? trailerCommonNavigation,
    Status? statusNavigation
  }){
    return Trailer(id ?? this.id, status ?? this.status, common ?? this.common, manufacturer ?? this.manufacturer, maintenance ?? this.maintenance,
    trailerCommonNavigation ?? this.trailerCommonNavigation, statusNavigation ?? this.statusNavigation);
  }
}

final class TrailerDecoder implements CSMDecodeInterface<Trailer> {
  const TrailerDecoder();

  @override
  Trailer decode(JObject json) {
    return Trailer.des(json);
  }
}
