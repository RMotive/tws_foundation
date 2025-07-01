import 'dart:typed_data';

import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

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

  //! --> Properties

  /// Wheter the record is an entry or exit entry.
  bool entry = false;

  /// Trailer seal information.
  ///
  /// Rules >
  ///   1. 65 > length > 9
  String? seal = "";

  /// Trailer alternative seal information.
  ///
  /// Rules >
  ///   1. 65 > length > 9
  String? sealAlt = "";

  /// Vehicule origin / destination information.
  ///
  /// Rules >
  ///   1. 101 > length > 9
  String fromTo = "";

  /// Vehicule entry image evidence.
  Uint8List evidence = Uint8List.fromList(<int>[]);

  /// Vehicule damage image evidence.
  Uint8List? damage;

  //! <-- Properties

  //! --> Relations

  /// [LoadType] information.
  LoadType loadType = LoadType();

  /// [Employee] information.
  Employee guard = Employee();

  /// [Section] information.
  Section section = Section();

  /// [DriverCommon] information.
  DriverCommon driver = DriverCommon();

  /// [TruckCommon] information.
  TruckCommon truck = TruckCommon();

  /// [TrailerCommon] information.
  TrailerCommon trailer = TrailerCommon();

  //! <-- Relations

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
        kLoadType: loadType.encode(),
        kGuard: guard.encode(),
        kSection: section.encode(),
        'driver': driver.encode(),
        'truck': truck.encode(),
        'trailer': trailer.encode(),
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

    loadType = encode.getEntity(() => LoadType(), kLoadType) ?? loadType;
    guard = encode.getEntity(() => Employee(), kGuard) ?? guard;
    section = encode.getEntity(() => Section(), kSection) ?? section;
    driver = encode.getEntity(() => DriverCommon(), 'driver') ?? driver;
    truck = encode.getEntity(() => TruckCommon(), 'truck') ?? truck;
    trailer = encode.getEntity(() => TrailerCommon(), 'trailer') ?? trailer;

    super.decode(encode);
  }

  @override
  List<EntityInvalidation<YardLog>> evaluate() {
    List<EntityInvalidation<YardLog>> results = <EntityInvalidation<YardLog>>[];
    if (evidence.isEmpty) results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kEvidence, Uint8List, evidence), "Debe tomar una foto del camión con el remolque.", "strictLength(1, max)"));
    if (fromTo.trim().isEmpty || fromTo.length > 100) {
      results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kFromTo, String, fromTo), "Debe indicar de donde viene (o a donde va el camión). Maximo 100 caracteres.", "strictLength(1,100)"));
    }
    // if(seal != null){
    //   if(trailerNavigation == null && trailerExternalNavigation == null) results.add(EntityInvalidation<YardLog>(kSeal, "Se ingreso un sello pero no un relmolque, seleccione alguno.", "FieldConflict()"));
    //   if(seal!.trim().isEmpty || seal!.length > 64) results.add(EntityInvalidation<YardLog>(kSeal, "El campo del sello no contiene un texto valido. Maximo 64 caracteres.", "strictLength(1,64)"));
    // }
    if (sealAlt != null) {
      if (sealAlt!.trim().isEmpty || sealAlt!.length > 64) {
        results.add(EntityInvalidation<YardLog>(this, PropertyInfo(kSealAlt, String, fromTo), "El campo del sello #2 (alternativo) es muy largo. Maximo 64 caracteres.", "strictLength(1,64)"));
      }
    }
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
