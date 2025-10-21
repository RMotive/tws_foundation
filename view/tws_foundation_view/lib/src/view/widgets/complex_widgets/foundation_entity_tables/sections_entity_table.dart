import 'dart:convert';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:flutter/services.dart' hide TextInput;
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/coordenates_precisio_formtter.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/data/const/static_collections.dart';
import 'package:tws_foundation_view/src/view/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/photo_taker/photo_taker.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements the [EntityTableAdapterB] for [LocationsEntityTable] {widget}.
final class SectionsEntityTableAdatper extends FoundationEntityTableAdapterB<Section> {
  /// Creates a new [SectionsEntityTableAdatper] instance.
  SectionsEntityTableAdatper({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, Section entity) {
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

        /// --> Description
        PropertyViewer(
          label: 'Description',
          value: entity.description,
        ),

        /// --> Status
        PropertyViewer(
          label: 'Status',
          value: entity.status.name,
        ),

        /// --> Capacity
        PropertyViewer(
          label: 'Capacity',
          value: entity.capacity.toString(),
        ),

        /// --> Resource
        PropertyViewer(
          label: 'Resource',
          value: entity.resource != null? 'Yes' : 'No',
        ),

        /// --> Addres section
        const SectionDivider(
          text: 'Yard details'
        ),

        /// --> Yard name
        PropertyViewer(
          label: 'Yard',
          value: entity.yard.name,
        ),

        /// --> Yard description 
        PropertyViewer(
          label: 'Description',
          value: entity.yard.description ?? '---',
        ),

        PropertyViewer(
          label: 'Country',
          value: entity.yard.address.country,
        ),

         PropertyViewer(
          label: 'City',
          value: entity.yard.address.city ?? '---',
        ),

         PropertyViewer(
          label: 'Street',
          value: entity.yard.address.street ?? '---',
        ),

    
      ],
    );
  }
  @override
  EntityTableAdapterEditor<Section>? composeEditor() {

    return EntityTableAdapterEditor<Section>(
      onUpdate: (BuildContext buildContext, Section entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },
      formBuilder:(BuildContext buildContext, Section entity) {
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

              TextInput(
                width: double.infinity,
                label: 'Capacity',
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: TextEditingController(
                  text: entity.capacity.toString(),
                ),
                onChanged: (String text) {
                  entity.capacity = int.tryParse(text) ?? -1;
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

              EntityFinderSelector<Location, LocationsServiceI>(
                entityBuilder:() => Location(),
                label: 'Select Yard',
                initialValue: entity.yard,
                textBuilder: (Location yard) {
                  return yard.name;
                },
                onSelected: (Location? yard) {
                  entity.yard = yard ?? Location();
                },
              ),

              if(entity.resource == null)
              FoldPanelWidget(
                title: 'Add Resource', 
                child: _buildResourceSection(entity),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildResourceSection(Section entity){
    return PhotoTaker(
      preLoadBase64: entity.resource != null? base64Encode(entity.resource!.file) : null,
      onPhotoTaken: (XFile photo) async {
        Resource resource = Resource();
        resource.file = await photo.readAsBytes();
        resource.name = 'Section_${entity.name}_at_${entity.timestamp}_Resource.${photo.path.split('.').last}';
        resource.extension = photo.path.split('.').last;
        entity.resource = resource;
      },
    );
  }
  void _onUpdate(Section entity, Router router, BuildContext context) async {
    SectionsServiceI sectionsService = Injector.get();

    List<EntityInvalidation<Section>> invalidations = entity.evaluate();

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

    FoundationResponseResolver<UpdateOutput<Section>> resResolver = await sectionsService.update(
      UpdateInput<Section>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<Section>(
            () => Section(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Section>> success) {
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
              title: 'Error Updating Truck',
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
  Widget _buildUpdateDialog(Section entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Section update',
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
          title: 'Status',
          value: entity.status.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Capacity',
          value: entity.capacity.toString(),
        ),
        TextLabel(
          title: 'Country',
          value: entity.yard.address.country.cleaned ?? '---',
        ),
        TextLabel(
          title: 'City',
          value: entity.yard.address.state ?? '---',
        ),
        TextLabel(
          title: 'Street',
          value: entity.yard.address.city ?? '---',
        ),
        TextLabel(
          title: 'Resource',
          value: entity.resource?.name ?? '---',
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {foundation} complex [EntityTable] based on [Section] {entity}, also handles basic available behavior.
final class SectionsEntityTable extends FoundationEntityTableB<SectionsEntityTableAdatper> {
  /// Creates a new [SectionsEntityTable] instance.
  const SectionsEntityTable({
    required super.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<Section, SectionsServiceI>(
      entityFactory: () => Section(),
      adapter: adapter,
      columns: <EntityTableColumnOptions<Section>>[
        /// --> Name
        EntityTableColumnOptions<Section>(
          title: 'Name',
          factory: (Section entity, int index, BuildContext buildContext) => entity.name,
        ),

        EntityTableColumnOptions<Section>(
          title: 'Capacity',
          factory: (Section entity, int index, BuildContext buildContext) => entity.capacity.toString(),
        ),

        /// --> Image resource.
        EntityTableColumnOptions<Section>(
          title: 'Resource',
          factory: (Section entity, int index, BuildContext buildContext) => entity.resource != null ? 'Yes' : 'No',
        ),

        /// --> Section status.
        EntityTableColumnOptions<Section>(
          title: 'Status',
          factory: (Section entity, int index, BuildContext buildContext) => entity.name,
        ),

        /// --> Country
        EntityTableColumnOptions<Section>(
          title: "Country",
          factory: (Section entity, int index, BuildContext buildContext) => entity.yard.address.country,
        ),
        /// --> State
        EntityTableColumnOptions<Section>(
          title: "State",
          factory: (Section entity, int index, BuildContext buildContext) => entity.yard.address.state ?? '---',
        ),
        /// --> City
        EntityTableColumnOptions<Section>(
          title: "City",
          factory: (Section entity, int index, BuildContext buildContext) => entity.yard.address.city ?? '---',
        ),
        /// --> Street
        EntityTableColumnOptions<Section>(
          title: "Street",
          factory: (Section entity, int index, BuildContext buildContext) => entity.yard.address.street ?? '---',
        ),
      ],
    );
  }
}
