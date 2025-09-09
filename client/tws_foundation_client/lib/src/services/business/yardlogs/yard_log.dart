import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/resources/resource.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog extends EntityB<YardLog> {
  /// [YardLog.entry] property key.
  static const String kEntry = 'entry';

  /// [YardLog.seal] property key.
  static const String kSeal = 'seal';

  /// [YardLog.sealAlt] property key.
  static const String kSealAlt = 'sealAlt';

  /// [YardLog.fromTo] property key.
  static const String kFromTo = 'fromTo';

  /// [YardLog.truck] property key.
  static const String kTruck = 'truck';

  /// [YardLog.trailer] property key.
  static const String kTrailer = 'trailer';

  /// [YardLog.driver] property key.
  static const String kDriver = 'driver';

  /// [YardLog.loadType] property key.
  static const String kLoadType = 'loadType';

  /// [YardLog.guard] property key.
  static const String kGuard = 'guard';

  /// [YardLog.section] property key.
  static const String kSection = 'section';

  /// [YardLog.resources] property key.
  static const String kResources = 'resources';

  /// [YardLog.reservation] property key.
  static const String kReservation = 'reservation';

  //! --> Properties

  /// Wheter the record is an entry or exit entry.
  bool entry = false;

  /// Wheter the records is a reservation or not.
  bool reservation = false;

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
  TrailerCommon? trailer = TrailerCommon();

  /// [Resource] content attached to the entry.
  /// In this list the truck and trailer, and any damage evidence photos are stored.
  List<Resource> resources = <Resource>[];

  //! <-- Relations

  //! --> Getters & Setters

  /// Retrieves a [Resource] from the [resources] list by searching for a matching name, using the .Contrains() string method.
  Resource? getResource(String search){
    resources.map(
      (Resource e) {
        return e.name.contains(search) ? e : null;
      },
    );
    return null;
  }

  /// Adds or replaces a [Resource] in the [resources] list. 
  /// If a [Resource] with the same name already exists, it will be replaced.
  void setResource(Resource resource, {int? replaceOnIndex}){
    // Remove any existing resource with the same name.
    resources.removeWhere((Resource e) => e.name == resource.name);
    
    if(replaceOnIndex != null && replaceOnIndex >= 0 && replaceOnIndex < resources.length){
      resources[replaceOnIndex] = resource;
      return;
    }
    resources.add(resource);
  }

  /// Searches for a [Resource] in the [resources] list by name, using the .Contains() string method, and returns its index.
  /// Returns -1 if not found.
  /// This method is useful for checking if a resource exists before adding or modifying it.
  int getIndexResource(String search){
    return resources.indexWhere((Resource e) => e.name.contains(search));
  }

  //! <-- Getters & Setters

  /// Creates a new [YardLog] instance with default values.
  YardLog();

  /// Validates nullable inputs to prevent [YardLog] entities with empty or invalid values.
  YardLog? sanitize({
    String? seal,
    String? sealAlt,
  }) {
    this.seal = seal.sanitizeOrFallback(this.seal);
    this.sealAlt = sealAlt.sanitizeOrFallback(this.sealAlt);


    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kEntry: entry,
        kSeal: seal,
        kSealAlt: sealAlt,
        kFromTo: fromTo,
        kReservation: reservation,
        kLoadType: loadType.encode(),
        kGuard: guard.encode(),
        kSection: section.encode(),
        kDriver: driver.encode(),
        kTruck: truck.encode(),
        kTrailer: trailer?.encode(),
        kResources: resources
            .map(
              (Resource e) => e.encode(),
            )
            .toList(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    entry = encode.get(kEntry);
    seal = encode.get(kSeal);
    sealAlt = encode.get(kSealAlt);
    fromTo = encode.get(kFromTo);
    reservation = encode.get(kReservation);
    loadType = encode.getEntity(() => LoadType(), kLoadType) ?? loadType;
    guard = encode.getEntity(() => Employee(), kGuard) ?? guard;
    section = encode.getEntity(() => Section(), kSection) ?? section;
    driver = encode.getEntity(() => DriverCommon(), kDriver) ?? driver;
    truck = encode.getEntity(() => TruckCommon(), kTruck) ?? truck;
    trailer = encode.getEntity(() => TrailerCommon(), kTrailer) ?? trailer;

    List<DataMap> resourceMaps = encode.getList(kResources);
    if (resourceMaps.isNotEmpty) {
      resources = resourceMaps.map<Resource>(
        (DataMap e) {
          Resource resource = Resource();
          resource.decode(e);
          return resource;
        },
      ).toList();
    }

    super.decode(encode);
  }

  @override
  List<EntityInvalidation<YardLog>> evaluate() {
    List<EntityInvalidation<YardLog>> invalidations = <EntityInvalidation<YardLog>>[];
     if (id < BigInt.zero) {
      invalidations.add(
        EntityInvalidation<YardLog>(
          this,
          PropertyInfo(EntityKeys.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }
    if (fromTo.trim().isEmpty || fromTo.length > 100) {
      invalidations.add(
        EntityInvalidation<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          "Debe indicar de donde viene (o a donde va el camión). Maximo 100 caracteres.",
          "101 > length > 0",
        ),
      );
    }
    if (seal != null) {
      if (trailer == null) {
        invalidations.add(
          EntityInvalidation<YardLog>(
            this,
            PropertyInfo(kSeal, String, seal),
            "Se ingreso un sello pero no un relmolque, seleccione alguno.",
            "trailer != null",
          ),
        );
      }
      // TODO: Check if seal never is null, when trailer is not null.
      if (seal!.trim().isEmpty || seal!.length > 64) {
        invalidations.add(
          EntityInvalidation<YardLog>(
            this,
            PropertyInfo(kSeal, String, seal),
            "Longitud de $kSeal invalido: ${seal!.length}. Debe contener entre 10 y 64 caracteres.",
            "65 > length > 9",
          ),
        );
      }
    }
    if (sealAlt != null) {
      if (sealAlt!.trim().isEmpty || sealAlt!.length > 64) {
        invalidations.add(
          EntityInvalidation<YardLog>(
            this,
            PropertyInfo(kSealAlt, String, fromTo),
            "Longitud del Sello #2: ${sealAlt!.length} es invalido. Debe contener entre 10 y 64 caracteres o estar vacio.",
            "65 > lenght > 9",
          ),
        );
      }
    }
    // Loadtype: 3 == "Botado"
    if (loadType.reference != "Botad001" && trailer == null) {
      invalidations.add(
        EntityInvalidation<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          'Tipo de carga: ${loadType.name}. Debe agregar los datos del remolque, de lo contrario seleccione el tipo de carga como Botado',
          'trailer != null',
        ),
      );
    }

    if (loadType.reference == "Botad001" && trailer != null) {
      invalidations.add(
        EntityInvalidation<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          'Tipo de carga: ${loadType.name}. No puede seleccionar un remolque, si el tipo de carga es Botado',
          'trailer == null',
        ),
      );
    }

    return invalidations;
  }
}
