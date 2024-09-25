import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/sets/set_common_keys.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Plate implements CSMSetInterface {
  static const String kIdentifier = "identifier";
  static const String kStatus = "status";
  static const String kState = "state";
  static const String kCountry = "country";
  static const String kExpiration = "expiration";
  static const String kTruck = "truck";
  static const String kTrailer = "trailer";
  static const String kstatusNavigation = "StatusNavigation";
  static const String kTruckCommonNavigation = "TruckCommonNavigation";
  static const String kTrailerCommonNavigation = "TrailerCommonNavigation";

  @override
  int id = 0;
  int status = 1;
  String identifier = "";
  String state = "";
  String country = "";
  DateTime expiration = DateTime.now();
  int? truck;
  int? trailer;
  Status? statusNavigation;
  TruckCommon? truckCommonNavigation;
  TrailerCommon? trailerCommonNavigation;

  Plate(this.id, this.status, this.identifier, this.state, this.country, this.expiration, this.truck, this.trailer, this.statusNavigation, this.truckCommonNavigation, this.trailerCommonNavigation);

  Plate.def();

  factory Plate.des(JObject json) {
    TruckCommon? truckCommonNavigation;
    if (json[kTruckCommonNavigation] != null) {
      truckCommonNavigation = TruckCommon.des(json[kTruckCommonNavigation]);
    }

    TrailerCommon? trailerNavigation;
    if (json[kTrailerCommonNavigation] != null) {
      trailerNavigation = TrailerCommon.des(json[kTrailerCommonNavigation]);
    }

    Status? statusNavigation;
    if (json[kstatusNavigation] != null) {
      JObject rawNavigation = json.getDefault(kstatusNavigation, <String, dynamic>{});
      statusNavigation = Status.des(rawNavigation);
    }
    int id = json.get(SCK.kId);
    int status = json.get(kStatus);
    String identifier = json.get(kIdentifier);
    String state = json.get(kState);
    String country = json.get(kCountry);
    DateTime expiration = json.get(kExpiration);
    int? truck = json.getDefault(kTruck, null);
    int? trailer = json.getDefault(kTrailer, null);

    return Plate(id, status, identifier, state, country, expiration, truck, trailer, statusNavigation, truckCommonNavigation, trailerNavigation);
  }

  Plate clone({
    int? id,
    int? status,
    String? identifier,
    String? state,
    String? country,
    DateTime? expiration,
    int? truck,
    int? trailer,
    Status? statusNavigation,
    TruckCommon? truckCommonNavigation,
    TrailerCommon? trailerCommonNavigation,
  }) {
    return Plate(
      id ?? this.id,
      status ?? this.status,
      identifier ?? this.identifier,
      state ?? this.state,
      country ?? this.country,
      expiration ?? this.expiration,
      truck ?? this.truck,
      trailer ?? this.trailer,
      statusNavigation ?? this.statusNavigation,
      truckCommonNavigation ?? this.truckCommonNavigation,
      trailerCommonNavigation ?? this.trailerCommonNavigation,
    );
  }

  @override
  JObject encode() {
    String exp = expiration.toString().substring(0, 10);

    return <String, dynamic>{
      SCK.kId: id,
      kStatus: status,
      kIdentifier: identifier,
      kState: state,
      kCountry: country,
      kExpiration: exp,
      kTruck: truck,
      kTrailer: trailer,
      kstatusNavigation: statusNavigation?.encode(),
      kTruckCommonNavigation: truckCommonNavigation?.encode(),
      kTrailerCommonNavigation: trailerCommonNavigation?.encode()
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if (identifier.length < 8 || identifier.length > 12) results.add(CSMSetValidationResult(kIdentifier, "Identifier length must be between 8 and 12", "strictLength(8,12)"));
    if (state.length < 2 || state.length > 4) results.add(CSMSetValidationResult(kState, "State length must be between 2 and 4", "strictLength(2,4)"));
    if (country.length < 2 || country.length > 3) results.add(CSMSetValidationResult(kCountry, "Country length must be between 2 and 3", "strictLength(2,3)"));

    return results;
  }
}
