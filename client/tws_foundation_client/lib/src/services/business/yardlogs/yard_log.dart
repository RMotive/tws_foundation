import 'dart:typed_data';
import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/entities/business/loadType.dart';
import 'package:tws_foundation_client/src/services/business/employees/employee.dart';
import 'package:tws_foundation_client/src/services/business/sections/sections.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog extends EntityB<YardLog> {
  /// [entry] property key.
  static const String kEntry = 'entry';
  /// [seal] property key.
  static const String kSeal = 'seal';
  /// [sealAlt] property key.
  static const String kSealAlt = 'sealAlt';
  /// [fromTo] property key.
  static const String kFromTo = 'fromTo';
  /// [evidence] property key.
  static const String kEvidence = 'evidence';
  /// [damage] property key.
  static const String kDamage = 'damage';
  /// [loadType] property key.
  static const String kLoadType = 'loadType';
  /// [guard] property key.
  static const String kGuard = 'guard';
  /// [guard] property key.
  static const String kSection = 'section';

  /// Wheter the record is an entry or exit entry.
  bool entry = false;

  /// Trailer seal information.
  String? seal = "";

  /// Trailer alternative seal information.
  String? sealAlt = "";

  /// Vehicule origin / destination information.
  String fromTo = "";

  /// Vehicule entry image evidence.
  Uint8List evidence = Uint8List.fromList(<int>[]);

  /// Vehicule damage image evidence.
  Uint8List? damage;

  /// Trailer load type.
  Loadtype? loadType;

  /// Guard filling out the yard log.
  Employee? guard;

  /// Guard filling out the yard log.
  Section? section;

  /// Creates a new [YardLog] instance with default values.
  YardLog();

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEntry: entry,
        kSeal: seal,
        kSealAlt: sealAlt,
        kFromTo: fromTo,
        kEvidence: evidence,
        kDamage: damage,
        kLoadType: loadType?.encode(),
        kGuard: guard?.encode(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    entry = encode.get(kEntry);
    seal = encode.get(kSeal);
    sealAlt = encode.get(kSealAlt);
    fromTo = encode.get(kFromTo);
    evidence = encode.get(kEvidence);
    damage = encode.get(kDamage);
    if(encode[kLoadType] != null){
      loadType = Loadtype();
      loadType!.decode(
          encode.get(kLoadType, DataMap()));
    }
    if(encode[kGuard] != null){
      guard = Employee();
      guard!.decode(
          encode.get(kGuard, DataMap()));
    }
    super.decode(encode);
  }

  @override
  List<EntityInvalidation<YardLog>> evaluate() {
    List<EntityInvalidation<YardLog>> results = <EntityInvalidation<YardLog>>[];
    if(evidence.isEmpty) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kEvidence, Uint8List, evidence), "Debe tomar una foto del camión con el remolque.", "strictLength(1, max)"));
    if(guard == null) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kGuard, Employee, guard), "Debe seleccionar el guardia que llena este formulario", "emptyEntity()"));
    if(fromTo.trim().isEmpty || fromTo.length > 100) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kFromTo, String, fromTo), "Debe indicar de donde viene (o a donde va el camión). Maximo 100 caracteres.", "strictLength(1,100)"));
    // if(seal != null){
    //   if(trailerNavigation == null && trailerExternalNavigation == null) results.add(EntityInvalidation<YardLog>(kSeal, "Se ingreso un sello pero no un relmolque, seleccione alguno.", "FieldConflict()"));
    //   if(seal!.trim().isEmpty || seal!.length > 64) results.add(EntityInvalidation<YardLog>(kSeal, "El campo del sello no contiene un texto valido. Maximo 64 caracteres.", "strictLength(1,64)"));
    // }
    if(sealAlt != null){
      if(sealAlt!.trim().isEmpty || sealAlt!.length > 64) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kSealAlt, String, fromTo), "El campo del sello #2 (alternativo) es muy largo. Maximo 64 caracteres.", "strictLength(1,64)"));
    }
    
    
    if(section == null && entry) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kSection, Section, section), 'Debe seleccionar una seccion.', 'pointerHandler()'));

    if(loadType == null) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kLoadType, Loadtype, loadType), 'Debe seleccionar el tipo de carga.', 'pointerHandler()'));

    // Loadtype: 3 == "Botado"
    // if (loadType != 3 && (trailerExternalNavigation == null && trailerNavigation == null)) {
    //   results.add(EntityInvalidation<YardLog>(kLoadType, 'Debe agregar los datos del remolque, de lo contrario seleccione el tipo de carga como Botado', 'FieldConflic()'));
    // }

    // if (loadType == 3 && (trailerExternalNavigation != null || trailerNavigation != null)) {
    //   results.add(EntityInvalidation<YardLog>(kLoadType, 'Si el tipo de carga es Botado, no puede seleccionar datos del remolque', 'FieldConflic()'));
    // }

    return results;
  }
}
