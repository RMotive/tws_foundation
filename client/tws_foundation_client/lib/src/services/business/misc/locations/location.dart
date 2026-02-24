import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [Location] default builder.
Location locationBuilder() => Location();

/// Defines a business entity that stores an specific [Address] and [Waypoint] location data for items, vehicules or buildings entities.
final class Location extends NamedEntityBase<Location> {
  /// [Location.address] Property key.
  static const String kAddress = "address";

  /// [Location.waypoint] Property key.
  static const String kWaypoint = "waypoint";

  /// [Location.sections] Property key.
  static const String kSections = "sections";

  /// [Location.address] navigation set.
  Address address = Address();

  /// [Location.status] information.
  Status status = Status();

  /// [Location.waypoint] navigation set.
  Waypoint? waypoint;

  /// [Location.sections]s information.
  List<Section> sections = <Section>[];

  /// Generates a new [Location] instance from mandatory values.
  Location();

  Location? sanitize({
    Address? address,
    Waypoint? waypoint,
    String? name,
    String? description,
  }) {
    this.address = address ?? this.address;
    this.waypoint = waypoint ?? this.waypoint;
    this.name = name.sanitizeOrFallback(this.name) ?? '';
    this.description = description.sanitizeOrFallback(this.description);
    
    if(waypoint != null && waypoint.id < BigInt.zero) {
      this.waypoint = null;
    }

    if (this.address.country.isEmpty &&
        this.name.isEmpty &&
        this.description == null &&
        this.waypoint == null &&
        this.address.id < BigInt.zero) {
      return null;
    }

    return this;
  }

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        kAddress: address.encode(),
        kWaypoint: waypoint?.encode(),
        FoundationCommonPropertyKeys.kStatus: status.encode(),
        kSections: sections
            .map(
              (Section e) => e.encode(),
            )
            .toList(),
      },
    );
  }

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    address = encode.getEntity(() => Address(), kAddress) ?? address;
    waypoint = encode.getEntity(() => Waypoint(), kWaypoint);
    status = encode.getEntity(() => Status(), FoundationCommonPropertyKeys.kStatus) ?? Status();
    List<DataMap> sectionsMaps = encode.getList(kSections);
    if (sectionsMaps.isNotEmpty) {
      sections = sectionsMaps.map<Section>(
        (DataMap e) {
          Section section = Section();
          section.decode(e);
          return section;
        },
      ).toList();
    }
  }

  @override
  List<EntityErrors<Location>> evaluate(List<EntityErrors<Location>> errors) {
    errors = super.evaluate(errors);

    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Location>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0',
          'id < 0',
        ),
      );
    }

    if (name.trim().isEmpty || name.length > 100) {
      errors.add(
        EntityErrors<Location>(
          this,
          PropertyInfo(CorePropertiesConsts.name, String, name),
          "Length: ${name.length}, must be between 1 and 100 characters",
          "101 > length > 0",
        ),
      );
    }
    if (description != null && (description!.trim().isEmpty || description!.length > 200)) {
      errors.add(
        EntityErrors<Location>(
          this,
          PropertyInfo(CorePropertiesConsts.description, String, description),
          "Length: ${description!.length}, must be empty or less than 200 characters",
          "length < 200",
        ),
      );
    }

    errors.validateDependency(this, address);
    errors.validateDependency(this, status);
    if(waypoint != null) errors.validateDependency(this, waypoint!);

    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Location ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);
    List <ObjectDifference> addressDiff = address.compare(ref.address);
    List <ObjectDifference> waypointDiff = waypoint?.compare(ref.waypoint ?? Waypoint()) ?? [];
    List <ObjectDifference> statusDiff = status.compare(ref.status);
    // List <ObjectDifference> sectionsDiff = section.compare(sections, ref.sections);

    if(addressDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kAddress, Address, address),
          address,
          ref.address,
          addressDiff,
        ),
      );
    }
    if (waypointDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(kWaypoint, Waypoint, waypoint),
          waypoint,
          ref.waypoint,
          waypointDiff,
        ),
      );
    }
    if(statusDiff.isNotEmpty) {
      aggregated.add(
        ObjectDifference(
          PropertyInfo(FoundationCommonPropertyKeys.kStatus, Status, status),
          status,
          ref.status,
          null,
        ),
      );
    }

    for(Section section in sections){
      Section? refSection = ref.sections.firstWhere((Section e) => e.id == section.id, orElse: () => Section());
      List<ObjectDifference> sectionDiff = section.compare(refSection);

      if (sectionDiff.isNotEmpty) {
        aggregated.add(
          ObjectDifference(
            PropertyInfo(kSections, Section, section),
            section,
            refSection,
            sectionDiff,
          ),
        );
      }
    }
   
   return aggregated;
  }
  
}
