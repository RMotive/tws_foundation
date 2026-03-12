import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Entity] that represents a vehicules control entry for a yard logging system where
/// guards write down an entry/exit journal of vehicles at business locations.
final class YardLog extends EntityBase<YardLog> {
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
  String? sealAlt;

  /// Vehicule origin / destination information.
  ///
  /// Rules >
  ///   1. 101 > length > 9
  String fromTo = "";

  //! <-- Properties

  //! --> Relations

  /// [Employee] information.
  Employee guard = Employee();

  /// [DriverCommon] information.
  DriverCommon driver = DriverCommon();

  /// [TruckCommon] information.
  TruckCommon truck = TruckCommon();

  /// [TrailerCommon] information.
  TrailerCommon? trailer = TrailerCommon();

  /// [LoadType] information.
  LoadType loadType = LoadType();

  /// [Section] information.
  Section? section;

  /// [Resource] content attached to the entry.
  /// 
  /// In this list the truck and trailer, and any damage evidence photos are stored.
  List<Resource> resources = <Resource>[];

  //! <-- Relations

  //! --> Getters & Setters

  /// Retrieves a [Resource] from the [resources] list by searching for a matching name, using the .Contrains() string method.
  Resource? getResource(String search){
    Resource match  = resources.firstWhere(
      (Resource e) => e.name.contains(search),
      orElse: () => Resource(),
    );
    return match.name.isEmpty ? null : match;
  }

  /// Adds or replaces a [Resource] in the [resources] list. 
  /// 
  /// If a [Resource] with the same name already exists, it will be replaced.
  /// 
  /// If [replaceOnRef] is provided, it will search for a resource with a name that contains the [replaceOnRef] string and replace it.
  void setResource(Resource resource, {String? replaceOnRef}){
    // Remove any existing resource with the same reference.
    late int replaceOnIndex;

    resource.name = 'Resource_${resource.name}_at_${DateTime.now()}';

    if(replaceOnRef != null){
      resources.removeWhere((Resource e) => e.name.contains(replaceOnRef));
      replaceOnIndex = getIndexResource(replaceOnRef);
    }
    
    if(replaceOnIndex != -1 && replaceOnIndex >= 0 && replaceOnIndex < resources.length){
      resources[replaceOnIndex] = resource;
      return;
    }

    resources.add(resource);
  }

  /// Searches for a [Resource] in the [resources] list by name, using the .Contains() string method, and returns its index.
  /// Returns -1 if not found.
  /// 
  /// This method is useful for checking if a resource exists before adding or modifying it.
  int getIndexResource(String search){
    return resources.indexWhere((Resource e) => e.name.contains(search));
  }

  //! <-- Getters & Setters

  /// Creates a new [YardLog] instance with default values.
  YardLog();

  /// Validates nullable inputs to prevent [YardLog] entities with empty or invalid values.
  void sanitize({
    String? seal,
    String? sealAlt,
  }) {
    this.seal = seal.sanitizeOrFallback(this.seal);
    this.sealAlt = sealAlt.sanitizeOrFallback(this.sealAlt);
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
        kSection: section?.encode(),
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
    loadType = encode.getEntity(() => LoadType(), kLoadType) ?? LoadType();
    guard = encode.getEntity(() => Employee(), kGuard) ?? guard;
    section = encode.getEntity(() => Section(), kSection);
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
  List<EntityErrors<YardLog>> evaluate(List<EntityErrors<YardLog>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<YardLog>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }
    if (fromTo.trim().isEmpty || fromTo.length > 100) {
      errors.add(
        EntityErrors<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          "Debe indicar de donde viene (o a donde va el camión). Maximo 100 caracteres.",
          "101 > length > 0",
        ),
      );
    }
    if (seal != null) {
      if (trailer == null) {
        errors.add(
          EntityErrors<YardLog>(
            this,
            PropertyInfo(kSeal, String, seal),
            "Se ingreso un sello pero no un relmolque, seleccione alguno.",
            "trailer != null",
          ),
        );
      }
      // TODO: Check if seal never is null, when trailer is not null.
      if (seal!.trim().isEmpty || seal!.length > 64) {
        errors.add(
          EntityErrors<YardLog>(
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
        errors.add(
          EntityErrors<YardLog>(
            this,
            PropertyInfo(kSealAlt, String, fromTo),
            "Longitud del Sello #2: ${sealAlt!.length} es invalido. Debe contener entre 10 y 64 caracteres o estar vacio.",
            "65 > lenght > 9",
          ),
        );
      }
    }
    if (loadType.reference != FoundationReferences.loadTypeBotado && trailer == null) {
      errors.add(
        EntityErrors<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          'Tipo de carga: ${loadType.name}. Debe agregar los datos del remolque, de lo contrario seleccione el tipo de carga como Botado',
          'trailer != null',
        ),
      );
    }

    if (loadType.reference == FoundationReferences.loadTypeBotado && trailer != null) {
      errors.add(
        EntityErrors<YardLog>(
          this,
          PropertyInfo(kFromTo, String, fromTo),
          'Tipo de carga: ${loadType.name}. No puede seleccionar un remolque, si el tipo de carga es Botado',
          'trailer == null',
        ),
      );
    }

    errors.validateDependency(this, loadType);
    errors.validateDependency(this, guard);
    if(section != null) errors.validateDependency(this, section!);
    errors.validateDependency(this, driver);
    errors.validateDependency(this, truck);
    if(trailer != null) errors.validateDependency(this, trailer!);

    /// resources validations -> [truckFront, truckLateral, trailerLateral, trailerBack]:
    List<bool> evidenceFlags = <bool>[false, false, false, false];

    if (resources.isNotEmpty) {
      for (Resource resource in resources) {
        errors.validateDependency(this, resource);
        evidenceFlags[0] = evidenceFlags[0] || resource.name.contains(FoundationReferences.truckFrontRes);
        evidenceFlags[1] = evidenceFlags[1] || resource.name.contains(FoundationReferences.truckLateralRes);
        evidenceFlags[2] = evidenceFlags[2] || resource.name.contains(FoundationReferences.trailerLateralRes);
        evidenceFlags[3] = evidenceFlags[3] || resource.name.contains(FoundationReferences.trailerBackRes);
      }
      if (trailer != null &&
          !evidenceFlags[2] &&
          !evidenceFlags[3]) {
        errors.add(
          EntityErrors<YardLog>(
            this,
            PropertyInfo(kResources, List<Resource>, resources),
            'Debe agregar alguna evidencia del remolque.',
            'resources contains ${FoundationReferences.trailerLateralRes} || ${FoundationReferences.trailerBackRes}',
          ),
        );
      }
      if(!evidenceFlags[0] && !evidenceFlags[1]){
        errors.add(
          EntityErrors<YardLog>(
            this,
            PropertyInfo(kResources, List<Resource>, resources),
            'Debe agregar la evidencia del camión.',
            'resources contains ${FoundationReferences.truckFrontRes} || ${FoundationReferences.truckLateralRes}',
          ),
        );
      }
    }




    return errors;
  }
  
  @override
  List<ObjectDifference> compare(YardLog ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);
    List<ObjectDifference> guardDiff = guard.compare(ref.guard);
    List<ObjectDifference> driverDiff = driver.compare(ref.driver);
    List<ObjectDifference> truckDiff = truck.compare(ref.truck);
    List<ObjectDifference> loadTypeDiff = loadType.compare(ref.loadType);

    if (entry != ref.entry) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kEntry, bool, entry),
          entry,
          ref.entry,
          null,
        ),
      );
    }

    if (reservation != ref.reservation) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kReservation, bool, reservation),
          reservation,
          ref.reservation,
          null,
        ),
      );
    }

    if (seal != ref.seal) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kSeal, String, seal),
          seal,
          ref.seal,
          null,
        ),
      );
    }

    if (sealAlt != ref.sealAlt) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kSealAlt, String, sealAlt),
          sealAlt,
          ref.sealAlt,
          null,
        ),
      );
    }

    if (fromTo != ref.fromTo) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kFromTo, String, fromTo),
          fromTo,
          ref.fromTo,
          null,
        ),
      );
    }

    if (guardDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kGuard, Employee, guard),
          guard,
          ref.guard,
          guardDiff,
        ),
      );
    }

    if (driverDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kDriver, DriverCommon, driver),
          driver,
          ref.driver,
          driverDiff,
        ),
      );
    }

    if (truckDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kTruck, TruckCommon, truck),
          truck,
          ref.truck,
          truckDiff,
        ),
      );
    }

    if (loadTypeDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kLoadType, LoadType, loadType),
          loadType,
          ref.loadType,
          loadTypeDiff,
        ),
      );
    }

    if (ref.trailer != null) {
      List<ObjectDifference> trailerDiff = trailer!.compare(ref.trailer!);
      if (trailerDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kTrailer, TrailerCommon, trailer),
            trailer,
            ref.trailer,
            trailerDiff,
          ),
        );
      }
    }

    if (ref.section != null) {
      List<ObjectDifference> sectionDiff = section!.compare(ref.section!);
      if (sectionDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kSection, Section, section),
            section,
            ref.section,
            sectionDiff,
          ),
        );
      }
    }

    for(Resource resource in resources){
      Resource refResource = ref.resources.firstWhere((Resource e) => e.id == resource.id, orElse: () => Resource());
      List<ObjectDifference> resourceDiff = resource.compare(refResource);

      if (resourceDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kResources, Resource, resource),
            resource,
            refResource,
            resourceDiff,
          ),
        );
      }
    }

    return aggregated;
  }
}
