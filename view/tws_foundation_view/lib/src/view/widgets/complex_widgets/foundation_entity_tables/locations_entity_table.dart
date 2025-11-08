import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:flutter/services.dart' hide TextInput;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/coordenates_formatter.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


/// Address state class.
class _AddresState extends ReactorB {}

_AddresState _addresState = _AddresState();
// ignore: unused_element
void Function() _addressEffect = () {};

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [LocationsEntityTable] {widget}.
final class LocationsEntityTableAdapter extends FoundationEntityTableAdapterB<Location> {
  /// Creates a new [LocationsEntityTableAdapter] instance.
  LocationsEntityTableAdapter({
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
  @override
  EntityTableAdapterEditor<Location>? composeEditor() {

    return EntityTableAdapterEditor<Location>(
      onUpdate: (BuildContext buildContext, Location entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },
      formBuilder:(BuildContext buildContext, Location entity) {
        const List<String> countries = FoundationCollections.kCountryList;
        const List<String> statesUSA = FoundationCollections.kUStateCodes;
        const List<String> statesMX = FoundationCollections.kMXStateCodes;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              TextInput(
                width: double.infinity,
                label: 'Timestamp',
                isEnabled: false,
                controller: TextEditingController(
                  text: entity.timestamp.fullDate,
                ),
              ),
              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 32,
                controller: TextEditingController(
                  text: entity.name,
                ),
                onChanged: (String text) {
                  entity.name = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'Description',
                maxLength: 32,
                controller: TextEditingController(
                  text: entity.description,
                ),
                onChanged: (String text) {
                  entity.description = text.cleaned;
                },
              ),
              EntityFinderSelector<Status, StatusesServiceI>(
                entityBuilder:() => Status(),
                label: 'Select Status',
                initialValue: entity.status,
                textBuilder: (Status status) {
                  return status.name;
                },
                onSelected: (Status? status) {
                  entity.status = status ?? Status();
                },
              ),

              /// --> Driver Address Information.
              const SectionDivider(
                text: "Address Information",
              ),

              AutoCompleteField<String>(
                width: double.maxFinite,
                nativeList: countries,
                initialValue: entity.address.country == "" ? null :  entity.address.country,
                displayValue:(String? item) => item ?? "Not valid data",
                label: 'Country',
                onChanged: (String? text) {
                  entity.address =
                      entity.address.sanitize(country: text ?? "") ?? Address().sanitize(country: text) ?? Address();
                  _addresState.react();
                },
              ),
              ReactiveWidget<_AddresState>(
                reactor: _addresState,
                builder: (BuildContext ctx, _AddresState state) {
                  final String currentCountry = entity.address.country;
                  _addressEffect = state.react;
                  return AutoCompleteField<String>(
                    width: double.maxFinite,
                    isEnabled: currentCountry.trim().isNotEmpty,
                    nativeList: currentCountry == countries[0] ? statesUSA : statesMX,
                    initialValue: entity.address.state == "" ? null : entity.address.state,
                    displayValue:(String? item) => item ?? "Not valid data",
                    label: '$currentCountry State',
                    isOptional: true,
                    onChanged: (String? text) {
                      entity.address = entity.address.sanitize(state: text ?? "") ?? Address().sanitize(state: text) ?? Address();
                    },
                  );
                },
              ),

              TextInput(
                width: double.maxFinite,
                deBounce: Duration(milliseconds: 300),
                label: 'City',
                maxLength: 30,
                isOptional: true,
                controller: TextEditingController(
                  text: entity.address.city,
                ),
                onChanged: (String text) {
                  entity.address = entity.address.sanitize(city: text) ?? Address().sanitize(city: text) ?? Address();
                },
              ),
              TextInput(
                label: 'Street',
                deBounce: Duration(milliseconds: 300),
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: entity.address.street,
                ),
                onChanged: (String text) {
                  entity.address = entity.address.sanitize(state: text) ?? Address().sanitize(state: text) ?? Address();
                },
              ),

              TextInput(
                label: 'Alternative Street',
                deBounce: Duration(milliseconds: 300),
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: entity.address.altStreet,
                ),
                onChanged: (String text) {
                  entity.address = entity.address.sanitize(altStreet: text) ?? Address().sanitize(altStreet: text) ?? Address();
                },
              ),

              TextInput(
                label: 'ZIP',
                deBounce: Duration(milliseconds: 300),
                maxLength: 5,
                isOptional: true,
                controller: TextEditingController(
                  text: entity.address.zip,
                ),
                onChanged: (String text) {
                  entity.address = entity.address.sanitize(zip: text) ?? Address().sanitize(zip: text) ?? Address();
                },
              ),

              TextInput(
                label: 'Subdivision/Colonia',
                deBounce: Duration(milliseconds: 300),
                maxLength: 30,
                isOptional: true,
                controller: TextEditingController(
                  text: entity.address.subdivision,
                ),
                onChanged: (String text) {
                  entity.address = entity.address.sanitize(subdivision: text) ?? Address().sanitize(subdivision: text) ?? Address();
                },
              ),
              const SectionDivider(
                text: "Waypoint Information",
              ),
              TextInput(
                label: 'Longitude',
                isOptional: true,
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
                  CoordenatesPrecisionFormtter(),
                ],
                controller: TextEditingController(

                  text: entity.waypoint?.longitude.toString(),
                ),
                onChanged: (String text) {
                  entity.waypoint = entity.waypoint?.sanitize(longitude: double.tryParse(text) ?? 0) ?? Waypoint().sanitize(longitude: double.tryParse(text) ?? 0);
                },
              ),

              TextInput(
                label: 'Latitude',
                isOptional: true,
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
                  CoordenatesPrecisionFormtter(),
                ],
                controller: TextEditingController(
                  text: entity.waypoint?.latitude.toString(),
                ),
                onChanged: (String text) {
                  entity.waypoint = entity.waypoint?.sanitize(latitude: double.tryParse(text) ?? 0) ?? Waypoint().sanitize(latitude: double.tryParse(text) ?? 0);
                },
              ),

              TextInput(
                label: 'Altitude',
                isOptional: true,
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
                  CoordenatesPrecisionFormtter(),
                ],
                controller: TextEditingController(
                  text: entity.waypoint?.altitude.toString(),
                ),
                onChanged: (String text) {
                  entity.waypoint = entity.waypoint?.sanitize(altitude: double.tryParse(text) ?? 0) ?? Waypoint().sanitize(altitude: double.tryParse(text) ?? 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _onUpdate(Location entity, Router router, BuildContext context) async {
    LocationsServiceI locationsService = Injector.get();

    List<EntityInvalidation<Location>> invalidations = entity.evaluate();

    if(invalidations.isNotEmpty){
      await showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InvalidatingDialog(
            title: 'Invalid Values',
            invalidations: invalidations,
            router: router,
            context: context,
          );
        },
      );
      return;
    }

    String authToken = await composeAuth();

    FoundationResponseResolver<UpdateOutput<Location>> resResolver = await locationsService.update(
      UpdateInput<Location>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<Location>(
            () => Location(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Location>> success) {
        refresh();
      },
      onFailure: (FailureFrame failure, int status) {
        errMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errMessage = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errMessage = FoundationMessages.connectionError;
      },
      onFinally: () {
        router.pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating Location',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: Theming.get<FoundationThemeB>(context).error,
              onAccept: () {
                router.pop();
              },
            );
          },
        );
      },
    );
  }
  Widget _buildUpdateDialog(Location entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Location update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Name',
          value: entity.name,
        ),
        TextLabel(
          title: 'Description',
          value: entity.description ?? '---',
        ),
        TextLabel(
          title: 'Country',
          value: entity.address.country,
        ),
        TextLabel(
          title: 'State',
          value: entity.address.state ?? '---',
        ),
        TextLabel(
          title: 'City',
          value: entity.address.city ?? '---',
        ),
        TextLabel(
          title: 'Street',
          value: entity.address.street ?? '---',
        ),
        TextLabel(
          title: 'Alt. street',
          value: entity.address.altStreet ?? '---',
        ),
        TextLabel(
          title: 'Zip',
          value: entity.address.zip ?? '---',
        ),
        TextLabel(
          title: 'Subdivision/Colonia',
          value: entity.address.subdivision ?? '---',
        ),
        TextLabel(
          title: 'Longitude',
          value: entity.waypoint?.longitude.toString() ?? '---',
        ),
        TextLabel(
          title: 'Latitude',
          value: entity.waypoint?.latitude.toString() ?? '---',
        ),
        TextLabel(
          title: 'Longitude',
          value: entity.waypoint?.altitude.toString() ?? '---',
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Location] {entity}, also handles basic available behavior.
final class LocationsEntityTable extends FoundationEntityTableB<LocationsEntityTableAdapter> {
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
