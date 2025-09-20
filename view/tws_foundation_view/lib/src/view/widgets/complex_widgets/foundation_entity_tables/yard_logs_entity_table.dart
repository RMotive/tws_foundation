import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:flutter_svg/svg.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/file_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/photo_taker/photo_taker.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {adapter} class.
///
/// Implements a custom [EntityTableAdapterB] for a [Solution] based [EntityTable] providing a foundation
/// {csm} data handling table for [Solution].
final class YardLogsEntityTableAdapter extends FoundationEntityTableAdapterB<YardLog> {
  /// Creates a new [YardLogsEntityTableAdapter] instance.
  YardLogsEntityTableAdapter({
    super.authBuilder,
  });

  @override
  Widget composeViewer(BuildContext buildContext, YardLog entity) {

    /// Getting resources evidences.
    Resource? damage1 = entity.getResource(FoundationReferences.damage1Res);
    Resource? damage2 = entity.getResource(FoundationReferences.damage2Res);

    Resource? truckFront = entity.getResource(FoundationReferences.truckFrontRes);
    Resource? truckLateral = entity.getResource(FoundationReferences.truckLateralRes);

    Resource? trailerBack = entity.getResource(FoundationReferences.trailerBackRes);
    Resource? trailerLateral = entity.getResource(FoundationReferences.trailerLateralRes);

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: <Widget>[
            SectionDivider(text: 'Yardlog details'),
            /// --> Creation date property view.
            PropertyViewer(
              label: 'Timestamp',
              value: entity.timestamp.fullDate,
            ),

            /// --> Event property view.
            PropertyViewer(
              label: 'Event',
              value: entity.entry ? 'In' : 'Out',
            ),

            /// --> Reservation property view.
            PropertyViewer(
              label: 'Reservation', 
              value: entity.reservation? 'Yes' : 'No',
            ),

            PropertyViewer(
              label: 'Guard', 
              value: '${entity.guard.identification.name} ${entity.guard.identification.lastName}',
            ),
            
            /// --> Driver section
            SectionWidget(
              title: "Driver",
              child: Column(
                spacing: 10,
                children: <Widget>[
                  /// --> Driver name property view.
                  PropertyViewer(
                    label: 'Name',
                    value: entity.driver.name,
                  ),

                  /// --> Driver licence property view.
                  PropertyViewer(
                    label: 'Licence',
                    value: entity.driver.license,
                  ),
                ],
              ),
            ),

            /// --> Truck section
            SectionWidget(
              title: "Truck",
              child: Column(
                spacing: 10,
                children: <Widget>[
                  /// --> Truck economic property view.
                  PropertyViewer(
                    label: 'Economic',
                    value: entity.truck.economic,
                  ),

                  /// --> Truck plates property view.
                  PropertyViewer(
                    label: 'Plates',
                    value: entity.truck.plates,
                  ),

                  /// --> Truck carrier property view.
                  PropertyViewer(
                    label: 'Carrier',
                    value: entity.truck.carrier,
                  ),
                ],
              ),
            ),

            /// --> Trailer type section.
            if(entity.trailer != null)
            SectionWidget(
              title: "Trailer",
              child: Column(
                spacing: 10,
                children: <Widget>[
                  /// --> Trailer economic property view.
                  PropertyViewer(
                    label: 'Economic',
                    value: entity.trailer!.economic,
                  ),

                  /// --> Trailer plates property view.
                  PropertyViewer(
                    label: 'Plates',
                    value: entity.trailer!.plates,
                  ),

                  /// --> Trailer type property view.
                  PropertyViewer(
                    label: 'Type',
                    value: entity.trailer!.classType,
                  ),
                ],
              ),
            ),
            
            /// --> Load Type property view.
            PropertyViewer(
              label: 'Load Type',
              value: entity.loadType.name,
            ),

            /// --> From/To property view.
            PropertyViewer(
              label: entity.entry? 'From' : 'To',
              value: entity.fromTo,
            ),
            
            /// --> First seal property view.
            PropertyViewer(
              label: 'Seal #1',
              value: entity.seal ?? '---',
            ),

            /// --> Second seal property view.
            PropertyViewer(
              label: 'Seal #2',
              value: entity.sealAlt ?? '---',
            ),

            /// --> Section property view.
            PropertyViewer(
              label: 'Section',
              value: '${entity.section.yard.name} - ${entity.section.name}',
            ),

            /// --> Log evidences.
            const SectionDivider(text: 'Evidences'),

            /// --> Damages evidences.
            SectionWidget(
              title: 'Damages', 
              child: Column(
                spacing: 10,
                children: <Widget>[
                  if(damage1 != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: damage1.file, 
                  ),

                  if(damage2 != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: damage2.file, 
                  ),

                  if(damage1 == null && damage2 == null)
                  const MessageWidget(text: 'No damages evidences'),
                ],
              ),
            ),

            /// --> Truck evidences.
            SectionWidget(
              title: 'Truck', 
              child: Column(
                spacing: 10,
                children: <Widget>[
                  if(truckFront != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: truckFront.file, 
                  ),

                  if(truckLateral != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: truckLateral.file, 
                  ),

                  if(truckFront == null && truckLateral == null)
                  const MessageWidget(text: 'No truck evidences'),
                ],
              ),
            ),

            /// --> Trailer evidences
            SectionWidget(
              title: 'Trailer', 
              child: Column(
                spacing: 10,
                children: <Widget>[
                  if(trailerBack != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: trailerBack.file, 
                  ),

                  if(trailerLateral != null)
                  PhotoTakerPhotoPreview(
                    originalBytes: trailerLateral.file, 
                  ),

                  if(trailerBack == null && trailerLateral == null)
                  const MessageWidget(text: 'No trailer evidences'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  EntityTableAdapterEditor<YardLog>? composeEditor() {
    return EntityTableAdapterEditor<YardLog>(
      onUpdate: (BuildContext buildContext, YardLog entity) {
        final Router router = Injector.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      }, 
      formBuilder:(BuildContext buildContext, YardLog entity) {
        final FoundationThemeB theme = Theming.get<FoundationThemeB>(buildContext);

        /// Getting resources evidences.
        Resource? damage1 = entity.getResource(FoundationReferences.damage1Res);
        Resource? damage2 = entity.getResource(FoundationReferences.damage2Res);

        Resource? truckFront = entity.getResource(FoundationReferences.truckFrontRes);
        Resource? truckLateral = entity.getResource(FoundationReferences.truckLateralRes);

        Resource? trailerBack = entity.getResource(FoundationReferences.trailerBackRes);
        Resource? trailerLateral = entity.getResource(FoundationReferences.trailerLateralRes);

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 10,
            children: <Widget>[
              const SectionDivider(text: 'Yardlog details'),
              OptionsSelector<bool>(
                title: 'Event',
                options:  <OptionsSelectorOption<bool>>[
                  OptionsSelectorOption<bool>(
                    title: 'In',
                    value: true,
                    resource: FoundationAssets.exitSvg,
                  ),
                  OptionsSelectorOption<bool>(
                    title: 'Out',
                    value: false,
                    resource: FoundationAssets.exitSvg,
                    iconRotation: 2,
                  ),
                ],
                onSelect: (List<bool> selected) {
                  entity.entry = selected.firstOrNull ?? false;
                },
              ),
              // --> Load Type Selection.
              // CatalogOptionsSelector<LoadType, LoadTypesServiceI>(
              //   title: 'Load Type',
              //   entityBuilder: () => LoadType(),
              //   onSelect: (List<LoadType> selection) => entity.loadType = selection[0],
              // ),
              /// --> Driver selection.
              EntityFinderSelector<DriverCommon, DriversServiceI>(
                entityBuilder: () => DriverCommon(),
                label: 'Select a Driver...',
                textBuilder: (DriverCommon driver) {
                  return "${driver.name} - ${driver.license}";
                },
                onSelected: (DriverCommon? driver) {
                  entity.driver = driver ?? DriverCommon();
                },
              ),
              EntityFinderSelector<TruckCommon, TrucksServiceI>(
                entityBuilder: () => TruckCommon(),
                label: 'Select a Truck...',
                textBuilder: (TruckCommon truck) {
                  return truck.economic;
                },
                onSelected: (TruckCommon? truck) {
                  entity.truck = truck ?? TruckCommon();
                },
              ),
              EntityFinderSelector<TrailerCommon, TrailersServiceI>(
                entityBuilder: () => TrailerCommon(),
                label: 'Select a Trailer...',
                textBuilder: (TrailerCommon trailer) {
                  return trailer.economic;
                },
                onSelected: (TrailerCommon? trailer) {
                  entity.trailer = trailer;
                },
              ),

              TextInput(
                width: double.maxFinite,
                maxLength: 100,
                label: entity.entry ? '*From' : '*To',
                hint: 'Ingresar información de origen/destino',
                onChanged: (String value) => entity.fromTo,
                controller: TextEditingController(
                  text: entity.fromTo,
                ),
              ),
              SectionWidget(
                title: 'Truck evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[

                  ],
                ),
              ),
              SectionWidget(
                title: 'Trailer evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[

                  ],
                ),
              ),
              SectionWidget(
                title: 'Damage evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    PhotoTakerPhotoPreview(
                        originalBytes:
                            entity.getResource(FoundationReferences.damage1Res)?.file ?? FoundationAssets.damagedSvg.bytes,
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      onSelect:(List<XFile> xFiles, _) async {
                        Resource resource = Resource();
                        resource.file = await xFiles.first.readAsBytes();
                        resource.name = FoundationReferences.damage1Res;
                        resource.extension = xFiles.first.path.split('.').last;
                        entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                      },  
                    ),
                    PhotoTakerPhotoPreview(
                        originalBytes:
                            entity.getResource(FoundationReferences.damage2Res)?.file ?? FoundationAssets.damagedSvg.bytes,
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      onSelect:(List<XFile> xFiles, _) async {
                        Resource resource = Resource();
                        resource.file = await xFiles.first.readAsBytes();
                        resource.name = FoundationReferences.damage2Res;
                        resource.extension = xFiles.first.path.split('.').last;
                        entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                      },  
                    ),
                  ],
                ),
              ),
              SectionWidget(
                title: 'Seals',
                child: Column(
                  spacing: 10,
                  children: <Widget>[

                  ],
                ),
              ),

              SectionWidget(
                title: 'Section', 
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    Expanded(
                      child: EntityFinderSelector<Section, SectionsServiceI>(
                        label: 'Section',
                        entityBuilder: () => Section(),
                        textBuilder: (Section section) {
                          return section.name;
                        },
                        onSelected: (Section? selSection) {
                          entity.section = selSection ?? Section();
                        } 
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        FoundationAssets.truckFrontSvg,
                        colorFilter: ColorFilter.mode(
                          theme.page.fore,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onUpdate(YardLog entity, Router router, BuildContext context) async {
    YardLogsServiceI yardLogsService = Injector.get();

    List<EntityInvalidation<YardLog>> invalidations = entity.evaluate();

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

    FoundationResponseResolver<UpdateOutput<YardLog>> resResolver = await yardLogsService.update(
      UpdateInput<YardLog>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder:
          () => UpdateOutput<YardLog>(
            () => YardLog(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<YardLog>> success) {
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
  Widget _buildUpdateDialog(YardLog entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Yardlog update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Event',
          value: entity.entry ? 'In' : 'Out',
        ),
        TextLabel(
          title: 'Reservation',
          value: entity.reservation ? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Guard',
          value: '${entity.guard.identification.name} ${entity.guard.identification.lastName}',
        ),
        TextLabel(
          title: 'Reservation',
          value: entity.reservation ? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Driver name',
          value: entity.driver.name ?? '---',
        ),
        TextLabel(
          title: 'Driver licence',
          value: entity.driver.license,
        ),
        TextLabel(
          title: 'Truck economic',
          value: entity.truck.economic,
        ),
        TextLabel(
          title: 'Truck plates',
          value: entity.truck.plates ?? "---",
        ),
        TextLabel(
          title: 'Truck carrier',
          value: entity.truck.carrier,
        ),
        if(entity.trailer != null)
        ...<TextLabel>[
          TextLabel(
            title: 'Trailer economic',
            value: entity.trailer!.economic,
          ),
          TextLabel(
            title: 'Trailer plates',
            value: entity.trailer!.plates ?? "---",
          ),
          TextLabel(
            title: 'Trailer type',
            value: entity.trailer!.classType ?? '---',
          ),
        ],
        TextLabel(
          title: 'Load type',
          value: entity.loadType.name,
        ),
        TextLabel(
          title: entity.entry? 'From': 'To',
          value: entity.fromTo,
        ),
        TextLabel(
          title: 'Seal #1',
          value: entity.seal ?? '---',
        ),
        TextLabel(
          title: 'Seal #2',
          value: entity.sealAlt ?? '---',
        ),
        TextLabel(
          title: 'Section',
          value: '${entity.section.yard.name} - ${entity.section.name}',
        ),
      ],
    );
  }
}

/// {widget} class.
///
/// Draws a {CSM} foundation [Solution] based [EntityTable], providing default interactions and management for [Solution] entity.
final class YardLogsEntityTable extends StatelessWidget {
  /// Table adapter handler.
  final YardLogsEntityTableAdapter adapter;

  /// Creates a new [YardLogsEntityTable] instance.
  const YardLogsEntityTable({
    super.key,
    required this.adapter,
  });

  @override
  Widget build(BuildContext context) {
    return EntityTable<YardLog, YardLogsServiceI>(
      adapter: adapter,
      entityFactory: () => YardLog(),
      columns: <EntityTableColumnOptions<YardLog>>[
        EntityTableColumnOptions<YardLog>(
          title: 'Entry',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.entry ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Date',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toIso8601String(),
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Load Type',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.loadType.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Drivers License',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.license,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Driver',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Truck Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Truck Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.plates,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Trailer Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.economic ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Trailer Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.plates ?? '---',
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Seal',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.seal,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Seal #2',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.sealAlt,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Origin - Destination',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.fromTo,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Damaged',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.getResource('damage') != null ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Section',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.section.name,
        ),
        EntityTableColumnOptions<YardLog>(
          title: 'Guard',
          factory: (YardLog entity, int index, BuildContext buildContext) {
            Identification guardIdent = entity.guard.identification;

            return '${guardIdent.name} ${guardIdent.lastName}';
          },
        ),
      ],
    );
  }
}
