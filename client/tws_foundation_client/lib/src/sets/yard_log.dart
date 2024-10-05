
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

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  @override
  int id = 0;
  bool entry = true;
  int? truck;
  int? truckExternal;
  int? trailer;
  int? trailerExternal;
  int loadType = 0;
  int section = 0;
  int? driver;
  int? driverExternal;
  int guard = 0;
  String gName = "";
  String fromTo = "";
  String? seal;
  bool damage = false;
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

  YardLog(this.id, this.entry, this.truck, this.truckExternal, this.trailer, this.trailerExternal, this.loadType, this.section, this.driver, this.driverExternal,
  this.guard, this.gName, this.fromTo, this.seal, this.damage, this.ttPicture, this.dmgEvidence, this.driverNavigation, this.driverExternalNavigation, this.truckNavigation, this.truckExternalNavigation,
  this.trailerNavigation, this.trailerExternalNavigation, this.loadTypeNavigation, this.sectionNavigation, this.accountNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }
  factory YardLog.des(JObject json) {
    int id = json.get('id');
    bool entry = json.get('entry');
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
    String? seal = json.getDefault('seal', null);
    bool damage = json.get('damage');
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

    return YardLog(id, entry, truck, truckExternal, trailer, trailerExternal, loadType, section, driver, driverExternal, guard, gName, fromTo, seal, damage,
    ttPicture, dmgEvidence, driverNavigation, driverExternalNavigation, truckNavigation, truckExternalNavigation, trailerNavigation, trailerExternalNavigation, loadTypeNavigation, sectionNavigation, null, timestamp: timestamp, );
  }

  @override
  JObject encode() {

    JObject request = <String, dynamic>{
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
      kTimestamp: timestamp.toIso8601String(),
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
    return request;
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    if(ttPicture.isEmpty ) results.add(CSMSetValidationResult(kTtPicture, "Debe tomar una foto del camión con el remolque.", "strictLength(1, max)"));
    if(gName.isEmpty || gName.length > 100) results.add(CSMSetValidationResult(kName, "El nombre del guardia no debe exeder los 100 caracteres y no debe estar vacio.", "strictLength(1,100)"));
    if(fromTo.isEmpty || fromTo.length > 100) results.add(CSMSetValidationResult(kFromTo, "Debe indicar de donde viene (o a donde va el camión). Maximo 25 caracteres.", "strictLength(1,25)"));
    if(seal != null){
      if(trailerNavigation == null || trailerExternalNavigation == null) results.add(CSMSetValidationResult(kSeal, "Se ingreso un sello pero no un relmolque, seleccione alguno.", "FieldConflict()"));
      if(seal!.isEmpty || seal!.length > 64) results.add(CSMSetValidationResult(kSeal, "El campo del sello no contiene un texto valido. Maximo 64 caracteres.", "strictLength(1,64)"));
    }
    if(seal == null && (trailerNavigation != null || trailerExternalNavigation != null)) results.add(CSMSetValidationResult(kSeal, "Debe agregar el campo de sello. De lo contrario seleccione el tipo de carga Botado.", "FieldConflict()"));
    if(section < 0) results.add(CSMSetValidationResult(kSection, 'Debe seleccionar la seccion.', 'pointerHandler()'));
    if(loadType < 0) results.add(CSMSetValidationResult(kLoadType, 'Debe seleccionar el tipo de carga.', 'pointerHandler()'));

    if(driverExternalNavigation == null && driverNavigation == null && driver == 0){
      results.add(CSMSetValidationResult(kDriver, 'Debe seleccionar un conductor', 'pointerHandler()'));
    }

    if(truckExternalNavigation == null && truckNavigation == null){
      results.add(CSMSetValidationResult(kTruck, 'Debe seleccionar un camion', 'pointerHandler()'));
    }


    //Loadtype: 3 == "Botado"
    if(loadType != 3 && (trailerExternalNavigation == null && trailerNavigation == null)){
      results.add(CSMSetValidationResult(kLoadType, 'Debe agregar los datos del remolque, de lo contrario seleccione el tipo de carga como Botado', 'FieldConflic()'));
    }
    
    if(loadType == 3 && (trailerExternalNavigation != null || trailerNavigation != null)){
      results.add(CSMSetValidationResult(kLoadType, 'Si el tipo de carga es Botado, no puede seleccionar datos del remolque', 'FieldConflic()'));
    }

    if(loadType <= 0) results.add(CSMSetValidationResult(kLoadType, 'Seleccione el tipo de carga.', 'pointerHandler()'));

    if(damage && dmgEvidence == null){
      results.add(CSMSetValidationResult(kDamage, 'Si selecciono la carga como dañada, debe tomar una foto del daño.', 'FieldConflic()'));
    }
    
    if(dmgEvidence != null && damage == false){
      results.add(CSMSetValidationResult(kDmgEvidence, 'Se registro una foto del daño, pero no se ha seleccionado la carga como dañada.', 'FieldConflic()'));
    }

    if(driverNavigation != null) results = <CSMSetValidationResult>[...results, ...driverNavigation!.evaluate()];   
    if(driverExternalNavigation != null) results = <CSMSetValidationResult>[...results, ...driverExternalNavigation!.evaluate()];   
    if(truckNavigation != null) results = <CSMSetValidationResult>[...results, ...truckNavigation!.evaluate()];   
    if(truckExternalNavigation != null) results = <CSMSetValidationResult>[...results, ...truckExternalNavigation!.evaluate()];   
    if(trailerNavigation != null) results = <CSMSetValidationResult>[...results, ...trailerNavigation!.evaluate()];   
    if(trailerExternalNavigation != null) results = <CSMSetValidationResult>[...results, ...trailerExternalNavigation!.evaluate()];   
    if(loadTypeNavigation != null) results = <CSMSetValidationResult>[...results, ...loadTypeNavigation!.evaluate()];   
    if(sectionNavigation != null) results = <CSMSetValidationResult>[...results, ...sectionNavigation!.evaluate()];   


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
    loadType ?? this.loadType, section ?? this.section, driverIndex,driverExtIndex, guard ?? this.guard, 
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
