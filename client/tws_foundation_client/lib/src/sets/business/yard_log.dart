import 'package:csm_client/csm_client.dart';
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
  static const String kSealAlt = "sealAlt";
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
  int? section;
  int? driver;
  int? driverExternal;
  int guard = 0;
  String gName = "";
  String fromTo = "";
  String? seal;
  String? sealAlt;
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
  this.guard, this.gName, this.fromTo, this.seal, this.sealAlt, this.damage, this.ttPicture, this.dmgEvidence, this.driverNavigation, this.driverExternalNavigation, this.truckNavigation, this.truckExternalNavigation,
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
    int? section = json.getDefault('section', null);
    int? driver = json.getDefault('driver', null);
    int? driverExternal = json.getDefault('driverExternal', null);
    DateTime timestamp = json.get('timestamp');
    int guard = json.get('guard');
    String gName = json.get('gName');
    String fromTo = json.get('fromTo');
    String? seal = json.getDefault('seal', null);
    String? sealAlt = json.getDefault('sealAlt', null);
    bool damage = json.get('damage');
    String ttPicture = json.get('ttPicture');
    String? dmgEvidence = json.getDefault('dmgEvidence', null);

    Driver? driverNavigation;
    if (json['DriverNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverNavigation', <String, dynamic>{});
      driverNavigation = Driver.des(rawNavigation);
    }
    DriverExternal? driverExternalNavigation;
    if (json['DriverExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('DriverExternalNavigation', <String, dynamic>{});
      driverExternalNavigation = DriverExternal.des(rawNavigation);
    }
    Truck? truckNavigation;
    if (json['TruckNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckNavigation', <String, dynamic>{});
      truckNavigation = Truck.des(rawNavigation);
    }
    TruckExternal? truckExternalNavigation;
    if (json['TruckExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TruckExternalNavigation', <String, dynamic>{});
      truckExternalNavigation = TruckExternal.des(rawNavigation);
    }
    Trailer? trailerNavigation;
    if (json['TrailerNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerNavigation', <String, dynamic>{});
      trailerNavigation = Trailer.des(rawNavigation);
    }
    TrailerExternal? trailerExternalNavigation;
    if (json['TrailerExternalNavigation'] != null) {
      JObject rawNavigation = json.getDefault('TrailerExternalNavigation', <String, dynamic>{});
      trailerExternalNavigation = TrailerExternal.des(rawNavigation);
    }
    LoadType? loadTypeNavigation;
    if (json['LoadTypeNavigation'] != null) {
      JObject rawNavigation = json.getDefault('LoadTypeNavigation', <String, dynamic>{});
      loadTypeNavigation = LoadType.des(rawNavigation);
    }
    Section? sectionNavigation;
    if (json['SectionNavigation'] != null) {
      JObject rawNavigation = json.getDefault('SectionNavigation', <String, dynamic>{});
      sectionNavigation = Section.des(rawNavigation);
    }

    return YardLog(id, entry, truck, truckExternal, trailer, trailerExternal, loadType, section, driver, driverExternal, guard, gName, fromTo, seal, sealAlt, damage,
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
      kSealAlt: sealAlt,
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
    if(gName.trim().isEmpty || gName.length > 100) results.add(CSMSetValidationResult(kName, "El nombre del guardia no debe exeder los 100 caracteres y no debe estar vacio.", "strictLength(1,100)"));
    if(fromTo.trim().isEmpty || fromTo.length > 100) results.add(CSMSetValidationResult(kFromTo, "Debe indicar de donde viene (o a donde va el camión). Maximo 100 caracteres.", "strictLength(1,100)"));
    if(seal != null){
      if(trailerNavigation == null && trailerExternalNavigation == null) results.add(CSMSetValidationResult(kSeal, "Se ingreso un sello pero no un relmolque, seleccione alguno.", "FieldConflict()"));
      if(seal!.trim().isEmpty || seal!.length > 64) results.add(CSMSetValidationResult(kSeal, "El campo del sello no contiene un texto valido. Maximo 64 caracteres.", "strictLength(1,64)"));
    }
    if(sealAlt != null){
      if(sealAlt!.trim().isEmpty || sealAlt!.length > 64) results.add(CSMSetValidationResult(kSealAlt, "El campo del sello #2 (alternativo) es muy largo. Maximo 64 caracteres.", "strictLength(1,64)"));
    }
    
    
    if((section == null || section == 0) && sectionNavigation == null && entry) results.add(CSMSetValidationResult(kSection, 'Debe seleccionar una seccion.', 'pointerHandler()'));

    if(loadType <= 0) results.add(CSMSetValidationResult(kLoadType, 'Debe seleccionar el tipo de carga.', 'pointerHandler()'));

    if(section != null) if(section! < 0) results.add(CSMSetValidationResult(kSection, 'Section pointer must be equal or greather than 0', 'pointerHandler()'));

    if(trailer != null){
      if(trailer! < 0) results.add(CSMSetValidationResult(kTrailer , 'Trailer pointer must be equal or greather than 0', 'pointerHandler()')); 
    }
    
    if(trailerExternal != null){
      if(trailerExternal! < 0) results.add(CSMSetValidationResult(kTrailerExternal , 'External trailer pointer must be equal or greather than 0', 'pointerHandler()')); 
    }

    if(truck != null){
      if(truck! < 0) results.add(CSMSetValidationResult(kTruck , 'Truck pointer must be equal or greather than 0', 'pointerHandler()'));
    }

    if(truckExternal != null){
      if(truckExternal! < 0) results.add(CSMSetValidationResult(kTruckExternal, 'External Truck pointer must be equal or greather than 0', 'pointerHandler()'));
    }

    if(driverExternal != null){
      if(driverExternal! < 0) results.add(CSMSetValidationResult(kDriverExternal, 'DriverExternal pointer must be equal or greather than 0', 'pointerHandler()'));
    }

    if(driver != null){
      if(driver! < 0) results.add(CSMSetValidationResult(kDriver, 'Driver pointer must be equal or greather than 0', 'pointerHandler()'));
    }

    if(driverExternalNavigation == null && driverNavigation == null){
      if( ((driver ?? 0) == 0) && ((driverExternal ?? 0) == 0) ) results.add(CSMSetValidationResult(kDriver, 'Debe seleccionar un conductor', 'pointerHandler()'));
    }

    if(truckExternalNavigation == null && truckNavigation == null){
      if( ((truck ?? 0) == 0) && ((truckExternal ?? 0) == 0) ) results.add(CSMSetValidationResult(kTruck, 'Debe seleccionar un camión', 'pointerHandler()'));
    }
    //Loadtype: 3 == "Botado"
    if (loadType != 3 && (trailerExternalNavigation == null && trailerNavigation == null)) {
      results.add(CSMSetValidationResult(kLoadType, 'Debe agregar los datos del remolque, de lo contrario seleccione el tipo de carga como Botado', 'FieldConflic()'));
    }

    if (loadType == 3 && (trailerExternalNavigation != null || trailerNavigation != null)) {
      results.add(CSMSetValidationResult(kLoadType, 'Si el tipo de carga es Botado, no puede seleccionar datos del remolque', 'FieldConflic()'));
    }

    if (damage && dmgEvidence == null) {
      results.add(CSMSetValidationResult(kDamage, 'Si selecciono la carga como dañada, debe tomar una foto del daño.', 'FieldConflic()'));
    }

    if (dmgEvidence != null && damage == false) {
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
  YardLog.a();
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
    String? sealAlt,
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
    Account? accountNavigation,
  }){
    String? sea = seal ?? this.seal;
    if(sea != null){
      if(sea.trim().isEmpty) sea = null;
    }

    String? sealt = sealAlt ?? this.sealAlt;
    if(sealt != null){
      if(sealt.trim().isEmpty) sealt = null;
    }

    String? dmgEv = dmgEvidence ?? this.dmgEvidence;
    if(dmgEv != null){
      if(dmgEv.trim().isEmpty) dmgEv = null;
    }

    if(gName != null){
      if(gName.trim().isEmpty) this.guard = 0;
    }

    if (loadType == 0){
      this.loadTypeNavigation = null;
      loadTypeNavigation = null;
    }

    if (section == 0) { 
      this.section = null;
      this.sectionNavigation = null;
      sectionNavigation = null;
      section = null;
    }

    if (driver == 0) {
      this.driver = null;
      this.driverNavigation = null;
      driverNavigation = null;
      driver = null;
    }

    if (driverExternal == 0) {
      this.driverExternal = null;
      this.driverExternalNavigation = null;
      driverExternalNavigation = null;
      driverExternal = null;
    }

    if (truck == 0) {
      this.truck = null;
      this.truckNavigation = null;
      truckExternalNavigation = null;
      truck = null;
    }

    if (truckExternal == 0) {
      this.truckExternal = null;
      this.truckExternalNavigation = null;
      truckExternalNavigation = null;
      truckExternal = null;
    }

    if (trailer == 0) {
      this.trailer = null;
      this.trailerNavigation = null;
      trailerNavigation = null;
      trailer = null;
    }

    if (trailerExternal == 0) {
      this.trailerExternal = null;
      this.trailerExternalNavigation = null;
      trailerExternalNavigation = null;
      trailerExternal = null;
    }
    
    return YardLog(
      id ?? this.id,
      entry ?? this.entry,
      truck ?? this.truck,
      truckExternal ?? this.truckExternal,
      trailer ?? this.trailer,
      trailerExternal ?? this.trailerExternal,
      loadType ?? this.loadType,
      section ?? this.section,
      driver ?? this.driver,
      driverExternal ?? this.driverExternal,
      guard ?? this.guard,
      gName ?? this.gName,
      fromTo ?? this.fromTo,
      sea,
      sealt,
      damage ?? this.damage,
      ttPicture ?? this.ttPicture,
      dmgEv,
      driverNavigation ?? this.driverNavigation,
      driverExternalNavigation ?? this.driverExternalNavigation,
      truckNavigation ?? this.truckNavigation,
      truckExternalNavigation ?? this.truckExternalNavigation,
      trailerNavigation ?? this.trailerNavigation,
      trailerExternalNavigation ?? this.trailerExternalNavigation,
      loadTypeNavigation ?? this.loadTypeNavigation,
      sectionNavigation ?? this.sectionNavigation,
      accountNavigation ?? this.accountNavigation,
    );
  }
}
