import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/extensions.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [LocationsEntityTable] {widget}.
final class LocationsEntityTableAdatper extends FoundationEntityTableAdapterB<Location> {
  /// Creates a new [LocationsEntityTableAdatper] instance.
  LocationsEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Location entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> TimeStamp
        PropertyViewer(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Name
        PropertyViewer(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Last Name
        PropertyViewer(
          label: 'Description',
          value: entity.description,
        ),

        /// --> Addres section
        const SectionDivider(
          text: 'Address details'
        ),

        /// --> Country
        PropertyViewer(
          label: 'Country',
          value: entity.address.country,
        ),

       /// --> State 
        PropertyViewer(
          label: 'State',
          value: entity.address.state ?? '---',
        ),

        /// --> City
        PropertyViewer(
          label: 'City',
          value: entity.address.city ?? '---',
        ),

        /// --> Street
        PropertyViewer(
          label: 'Street',
          value: entity.address.street ?? '---',
        ),

        /// --> Alternative street
        PropertyViewer(
          label: 'Country',
          value: entity.address.country,
        ),

        /// --> Zip number
        PropertyViewer(
          label: 'Zip',
          value: entity.address.zip ?? '---',
        ),

        /// --> Subdivision
        PropertyViewer(
          label: 'Subdivision',
          value: entity.address.subdivision ?? '---',
        ),

        /// --> Waypoint section
        const SectionDivider(
          text: 'Waypoint details',
        ),

        /// --> Longitude
        PropertyViewer(
          label: 'Longitude',
          value: entity.waypoint?.longitude.toString() ?? '---',
        ),

        /// --> Latitude
        PropertyViewer(
          label: 'Latitude',
          value: entity.waypoint?.latitude.toString() ?? '---',
        ),

        /// --> Altitude
        PropertyViewer(
          label: 'altitude',
          value: entity.waypoint?.altitude?.toString() ?? '---',
        ),

    
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Location] {entity}, also handles basic available behavior.
final class LocationsEntityTable extends FoundationEntityTableB<LocationsEntityTableAdatper> {
  /// Creates a new [LocationsEntityTable] instance.
  const LocationsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Location, LocationsServiceI>(
      entityFactory: () => Location(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Location>>[
        /// --> Name
        EntityTableColumnOptions<Location>(
          title: 'Name',
          factory: (Location entity, int index, BuildContext buildContext) => entity.name,
        ),
        /// --> Country
        EntityTableColumnOptions<Location>(
          title: "Country",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.country,
        ),
        /// --> State
        EntityTableColumnOptions<Location>(
          title: "State",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.state ?? '---',
        ),
        /// --> City
        EntityTableColumnOptions<Location>(
          title: "City",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.city ?? '---',
        ),
        /// --> Street
        EntityTableColumnOptions<Location>(
          title: "Street",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.street ?? '---',
        ),
        /// --> Alternative Street
        EntityTableColumnOptions<Location>(
          title: "Alt. Street",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.altStreet ?? '---',
        ),
        /// --> Zip number
        EntityTableColumnOptions<Location>(
          title: "ZIP",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.zip ?? '---',
        ),
        /// --> Subdivision/Colonia
        EntityTableColumnOptions<Location>(
          title: "Subdivision",
          factory: (Location entity, int index, BuildContext buildContext) => entity.address.subdivision ?? '---',
        ),        
      ],
    );
  }
}
