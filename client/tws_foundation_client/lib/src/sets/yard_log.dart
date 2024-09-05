
import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class YardLog implements CSMSetInterface {
  static const String kName = "name";
  static const String kEntry = "entry";
  static const String kTruck = "truck";
  static const String kTruckExternal = "truckExternal";
  static const String kTrailer = "trailer";
  static const String kTrailerExternal = "trailerExternal";
  static const String kLoadType = "loadType";
  static const String kSection = "section";
  static const String kDriver = "driver";
  static const String kDriverExternal = "driverExternal";
  static const String kTimestamp = "timestamp";
  static const String kGuard = "guard";
  static const String kGName = "gname";
  static const String kFromTo = "fromTo";
  static const String kSeal = "seal";
  static const String kDamage = "damage";
  static const String kTtPicture = "ttPicture";
  static const String kDmgEvidence = "dmgEvidence";
  static const String kDriverNavigation = "DriverNavigation";
  static const String kDriverExternalNavigation = "DriverExternalNavigation";
  static const String kTruckNavigation = "TruckNavigation";
  static const String kTruckExternalNavigation = "TruckExternalNavigation";
  static const String kTrailerNavigation = "TrailerNavigation";
  static const String kTrailerExternalNavigation = "TrailerExternalNavigation";
  static const String kLoadTypeNavigation = "LoadTypeNavigation";
  static const String kSectionNavigation = "SectionNavigation";
  static const String kAccount = "AccountNavigation";

  @override
  int id = 0;
  bool? entry; //Optional only for client porpuses.
  int? truck;
  int? truckExternal;
  int? trailer;
  int? trailerExternal;
  int loadType = 0;
  int section = 0;
  int? driver;
  int? driverExternal;
  DateTime? timestamp;
  int guard = 0;
  String gName = "";
  String fromTo = "";
  String seal = "";
  bool? damage; //Optional only for client porpuses.
  String ttPicture = "";
  String? dmgEvidence;
  Driver? driverNavigation;
  DriverExternal? driverExternalNavigation;
  Truck? truckNavigation;
  TruckExternal? truckExternalNavigation;
  Trailer? trailerNavigation;
  TrailerExternal? trailerExternalNavigation;
  LoadType? loadTypeNavigation;
  Section? sectionNavigation;
  Account? accountNavigation; //Only for local handle.

  YardLog(this.id, this.entry, this.truck, this.truckExternal, this.trailer, this.trailerExternal, this.loadType, this.section, this.driver, this.driverExternal, this.timestamp,
  this.guard, this.gName, this.fromTo, this.seal, this.damage, this.ttPicture, this.dmgEvidence, this.driverNavigation, this.driverExternalNavigation, this.truckNavigation, this.truckExternalNavigation,
  this.trailerNavigation, this.trailerExternalNavigation, this.loadTypeNavigation, this.sectionNavigation, this.accountNavigation);
  factory YardLog.des(JObject json) {
    int id = json.get('id');
    bool? entry = json.getDefault('entry', null);
    int? truck = json.getDefault('truck', null);
    int? truckExternal = json.getDefault('truckExternal', null);
    int? trailer = json.getDefault('trailer', null);
    int? trailerExternal = json.getDefault('trailerExternal', null);
    int loadType = json.get('loadtype');
    int section = json.get('section');
    int? driver = json.getDefault('driver', null);
    int? driverExternal = json.getDefault('driverExternal', null);
    DateTime timestamp = json.get('timestamp');
    int guard = json.get('guard');
    String gName = json.get('gName');
    String fromTo = json.get('fromTo');
    String seal = json.get('seal');
    bool? damage = json.getDefault('damage', null);
    String ttPicture = json.get('ttPicture');
    String? dmgEvidence = json.getDefault('dmgEvidence', null);

    Driver? driverNavigation;
    if (json['DriverNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverNavigation', <String, dynamic>{});
      driverNavigation = deserealize<Driver>(rawNavigation, decode: DriverDecoder());
    }
    DriverExternal? driverExternalNavigation;
    if (json['DriverExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverExternalNavigation', <String, dynamic>{});
      driverExternalNavigation = deserealize<DriverExternal>(rawNavigation, decode: DriverExternalDecoder());
    }
    Truck? truckNavigation;
    if (json['TruckNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckNavigation', <String, dynamic>{});
      truckNavigation = deserealize<Truck>(rawNavigation, decode: TruckDecoder());
    }
    TruckExternal? truckExternalNavigation;
    if (json['TruckExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckExternalNavigation', <String, dynamic>{});
      truckExternalNavigation = deserealize<TruckExternal>(rawNavigation, decode: TruckExternalDecoder());
    }
    Trailer? trailerNavigation;
    if (json['TrailerNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerNavigation', <String, dynamic>{});
      trailerNavigation = deserealize<Trailer>(rawNavigation, decode: TrailerDecoder());
    }
    TrailerExternal? trailerExternalNavigation;
    if (json['TrailerExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerExternalNavigation', <String, dynamic>{});
      trailerExternalNavigation = deserealize<TrailerExternal>(rawNavigation, decode: TrailerExternalDecoder());
    }
    LoadType? loadTypeNavigation;
    if (json['LoadTypeNavigation'] != null) {
      JObject rawNavigation = json.getDefault('LoadTypeNavigation', <String, dynamic>{});
      loadTypeNavigation = deserealize<LoadType>(rawNavigation, decode: LoadTypeDecoder());
    }
    Section? sectionNavigation;
    if (json['SectionNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SectionNavigation', <String, dynamic>{});
      sectionNavigation = deserealize<Section>(rawNavigation, decode: SectionDecoder());
    }

    return YardLog(id, entry, truck, truckExternal, trailer, trailerExternal, loadType, section, driver, driverExternal, timestamp, guard, gName, fromTo, seal, damage,
    ttPicture, dmgEvidence, driverNavigation, driverExternalNavigation, truckNavigation, truckExternalNavigation, trailerNavigation, trailerExternalNavigation, loadTypeNavigation, sectionNavigation, null);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'id': id,
      kEntry: entry,
      kTruck: truck,
      kTruckExternal: truckExternal,
      kTrailer: trailer,
      kTrailerExternal: trailerExternal,
      kLoadType: loadType,
      kSection: section,
      kDriver: driver,
      kDriverExternal: driverExternal,
      kTimestamp: timestamp?.toIso8601String(),
      kGuard: guard,
      kGName: gName,
      kFromTo: fromTo,
      kSeal: seal,
      kDamage: damage,
      kTtPicture: ttPicture,
      kDmgEvidence: dmgEvidence,
      kDriverNavigation: driverNavigation?.encode(),
      kDriverExternalNavigation: driverExternalNavigation?.encode(),
      kTruckNavigation: truckNavigation?.encode(),
      kTruckExternalNavigation: truckExternalNavigation?.encode(),
      kTrailerNavigation: trailerNavigation?.encode(),
      kTrailerExternalNavigation: trailerExternalNavigation?.encode(),
      kLoadTypeNavigation: loadTypeNavigation?.encode(),
      kSectionNavigation: sectionNavigation?.encode(),
    };
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(ttPicture.isEmpty ) results.add(CSMSetValidationResult(kTtPicture, "Debe tomar una foto del camión con el remolque.", "strictLength(1, max)"));
    if(gName.isEmpty || gName.length > 100) results.add(CSMSetValidationResult(kName, "El nombre del guardia no debe exeder los 100 caracteres y no debe estar vacio.", "strictLength(1,100)"));
    if(fromTo.isEmpty || fromTo.length > 100) results.add(CSMSetValidationResult(kFromTo, "Debe indicar de donde viene (o a donde va el camión). Maximo 25 caracteres.", "strictLength(1,25)"));
    if(seal.isEmpty || gName.length > 64) results.add(CSMSetValidationResult(kSeal, "El campo del sello no debe estar vacio. Maximo 100 caracteres.", "strictLength(1,64)"));
    if(section < 0) results.add(CSMSetValidationResult(kSection, 'Debe seleccionar la seccion.', 'pointerHandler()'));
    if(loadType < 0) results.add(CSMSetValidationResult(kLoadType, 'Debe seleccionar el tipo de carga.', 'pointerHandler()'));

    if(entry == null){
      results.add(CSMSetValidationResult(kEntry, 'Debe seleccionar si el registro es de entrada o salida.', 'pointerHandler()'));
    }

    if(driverExternalNavigation == null && driverNavigation == null){
      results.add(CSMSetValidationResult(kDriver, 'Debe seleccionar un conductor', 'pointerHandler()'));
    }

    if(truckExternalNavigation == null && truckNavigation == null){
      results.add(CSMSetValidationResult(kTruckExternalNavigation, 'Debe seleccionar un camion', 'pointerHandler()'));
    }

    if(loadTypeNavigation?.name == "Botado" && (trailerExternalNavigation != null || trailerNavigation != null)){
      results.add(CSMSetValidationResult(kLoadType, 'Si el tipo de carga es Botado, no puede seleccionar datos del remolque', 'FieldConflic()'));
    }

    if(damage == null){
      results.add(CSMSetValidationResult(kEntry, 'Debe indicar si la carga tiene algun daño o no.', 'pointerHandler()'));
    }else{
      if( damage! && dmgEvidence == null){
        results.add(CSMSetValidationResult(kDamage, 'Si selecciono la carga como dañada, debe tomar una foto del daño.', 'FieldConflic()'));
      }
    }
    

    if(dmgEvidence != null && damage == false){
      results.add(CSMSetValidationResult(kDmgEvidence, 'Se registro una foto del daño, pero no se ha seleccionado la carga como dañada.', 'FieldConflic()'));
    }

    return results;
  }
  YardLog.def();
  YardLog clone({
    int? id,
    bool? entry,
    int? truck,
    int? truckExternal,
    int? trailer,
    int? trailerExternal,
    int? loadType,
    int? section,
    int? driver,
    int? driverExternal,
    DateTime? timestamp,
    int? guard,
    String? gName,
    String? fromTo,
    String? seal,
    bool? damage,
    String? ttPicture,
    String? dmgEvidence,
    Driver? driverNavigation,
    DriverExternal? driverExternalNavigation,
    Truck? truckNavigation,
    TruckExternal? truckExternalNavigation,
    Trailer? trailerNavigation,
    TrailerExternal? trailerExternalNavigation,
    LoadType? loadTypeNavigation,
    Section? sectionNavigation,
    Account? accountNavigation
  }){
    //
    String? dmgEv = dmgEvidence ?? this.dmgEvidence;
    if(dmgEv == "") dmgEv = null;

    if(gName == "") this.guard = 0;

    LoadType? load = loadTypeNavigation ?? this.loadTypeNavigation;
    if(loadType == 0) load = null;

    Section? sect = sectionNavigation ?? this.sectionNavigation;
    if(section == 0) sect = null;

    int? driverIndex = driver ?? this.driver;
    Driver? driverNav = driverNavigation ?? this.driverNavigation;
    if(driverIndex == 0){
      driverIndex = null;
      driverNav = null; 
    }

    int? driverExtIndex = driverExternal ?? this.driverExternal;
    DriverExternal? driverExtNav = driverExternalNavigation ?? this.driverExternalNavigation;
    if(driverExtIndex == 0){
      driverExtIndex = null;
      driverExtNav = null; 
    }

    int? truckIndex = truck ?? this.truck;
    Truck? truckNav = truckNavigation ?? this.truckNavigation;
    if(truckIndex == 0){
      truckIndex = null;
      truckNav = null; 
    }

    int? truckExtIndex = truckExternal ?? this.truckExternal;
    TruckExternal? truckExtNav = truckExternalNavigation ?? this.truckExternalNavigation;
    if(truckExtIndex == 0){
      truckExtIndex = null;
      truckExtNav = null; 
    }

    int? trailerIndex = trailer ?? this.trailer;
    Trailer? trailerNav = trailerNavigation ?? this.trailerNavigation;
    if(trailerIndex == 0){
      trailerIndex = null;
      trailerNav = null; 
    }

    int? trailerExtIndex = trailerExternal ?? this.trailerExternal;
    TrailerExternal? trailerExtNav = trailerExternalNavigation ?? this.trailerExternalNavigation;
    if(trailerExtIndex == 0){
      trailerExtIndex = null;
      trailerExtNav = null; 
    }
    
    return YardLog(id ?? this.id, entry ?? this.entry, truckIndex, truckExtIndex, trailerIndex, trailerExtIndex, 
    loadType ?? this.loadType, section ?? this.section, driverIndex,driverExtIndex, timestamp ?? this.timestamp, guard ?? this.guard, 
    gName ?? this.gName, fromTo ?? this.fromTo, seal ?? this.seal, damage ?? this.damage, ttPicture ?? this.ttPicture, dmgEv, driverNav, 
    driverExtNav, truckNav, truckExtNav, trailerNav, trailerExtNav, load, sect, accountNavigation ?? this.accountNavigation);
  }

}

final class YardLogDecoder implements CSMDecodeInterface<YardLog> {
  const YardLogDecoder();

  @override
  YardLog decode(JObject json) {
    return YardLog.des(json);
  }
}
