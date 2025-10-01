import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:flutter_svg/svg.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/foundation_entity_tables/_foundation_entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/invalidating_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/dialog_widgets/resume_dialog.dart';
import 'package:tws_foundation_view/src/view/widgets/file_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/image_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/property_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Damage state class.
class _Damage1State extends ReactorB {}
_Damage1State _damage1State = _Damage1State();
void Function() _damage1React = () {};

class _Damage2State extends ReactorB {}
_Damage2State _damage2State = _Damage2State();
void Function() _damage2React = () {};

class _TruckFrontState extends ReactorB {}
_TruckFrontState _truckFrontState = _TruckFrontState();
void Function() _truckFrontReact = () {};

class _TruckLateralState extends ReactorB {}
_TruckLateralState _truckLateralState = _TruckLateralState();
void Function() _truckLateralReact = () {};

class _TrailerBackState extends ReactorB {}
_TrailerBackState _trailerBackState = _TrailerBackState();
void Function() _trailerBackReact = () {};

class _TrailerLateralState extends ReactorB {}
_TrailerLateralState _trailerLateralState = _TrailerLateralState();
void Function() _trailerLateralReact = () {};

class _Seal1State extends ReactorB {}
_Seal1State _seal1State = _Seal1State();
void Function() _seal1React = () {};

class _Seal2State extends ReactorB {}
_Seal2State _seal2State = _Seal2State();
void Function() _seal2React = () {};

class _SectionState extends ReactorB {}
_SectionState _sectionState = _SectionState();
void Function() _sectionReact = () {};

class _BlendedSVG extends StatelessWidget {
  final String route;
  const _BlendedSVG({
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    FoundationThemeB theme = Theming.get<FoundationThemeB>(context);
    return SvgPicture.asset(
      route,
      colorFilter: ColorFilter.mode(
        theme.page.fore,
        BlendMode.srcIn,
      ),
    );
  }
}

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

    Resource? seal1 = entity.getResource(FoundationReferences.seal1Res);
    Resource? seal2 = entity.getResource(FoundationReferences.seal2Res);

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            SectionDivider(text: 'Yardlog details'),
            /// --> Creation date property view.
            PropertyViewer(
              label: 'Timestamp',
              value: entity.timestamp.fullDate,
            ),

            /// --> Reservation property view.
            PropertyViewer(
              label: 'Reservation', 
              value: entity.reservation? 'Yes' : 'No',
            ),

            /// --> Event property view.
            PropertyViewer(
              label: 'Event',
              value: entity.entry ? 'In' : 'Out',
            ),

            PropertyViewer(
              label: 'Guard', 
              value: '${entity.guard.identification.name} ${entity.guard.identification.lastName}',
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
            
            /// --> Section property view.
            PropertyViewer(
              label: 'Section',
              value: entity.section != null? '${entity.section!.yard.name} - ${entity.section!.name}' : '---',
            ),
            
            /// --> Driver section
            const SectionDivider(text: 'Driver'),
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
            /// --> Truck section
            const SectionDivider(text: 'Truck'),
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
            /// --> Trailer type section.
            if(entity.trailer != null)
            ...<Widget>[
              const SectionDivider(text: 'Trailer'),
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

            /// --> Log evidences.
            const SectionDivider(text: 'Evidences'),
            SectionWidget(
              title: 'Seals', 
              outterPadding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: <Widget>[
                      /// --> First seal property view.
                      PropertyViewer(
                        label: 'Seal #1',
                        value: entity.seal,
                      ),
                  
                      if(seal1 != null)
                      ImageViewer(
                        resource: seal1, 
                      ),
                  
                      /// --> Second seal property view.
                      PropertyViewer(
                        label: 'Seal #2',
                        value: entity.sealAlt,
                      ),
                  
                      if(seal2 != null)
                      ImageViewer(
                        resource: seal2, 
                      ),
                    ],
                  ),
                ),
              )
            ),

            /// --> Truck evidences.
            SectionWidget(
              outterPadding: EdgeInsets.zero,
              title: 'Truck', 
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: <Widget>[
                      if(truckFront != null)
                      ImageViewer(
                        resource: truckFront, 
                      ),
                  
                      if(truckLateral != null)
                      ImageViewer(
                        resource: truckLateral, 
                      ),
                  
                      if(truckFront == null && truckLateral == null)
                      const MessageWidget(text: 'No truck evidences'),
                    ],
                  ),
                ),
              ),
            ),

            /// --> Trailer evidences
            SectionWidget(
              outterPadding: EdgeInsets.zero,
              title: 'Trailer', 
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: <Widget>[
                      if(trailerBack != null)
                      ImageViewer(
                        resource: trailerBack, 
                      ),
                  
                      if(trailerLateral != null)
                      ImageViewer(
                        resource: trailerLateral, 
                      ),
                  
                      if(trailerBack == null && trailerLateral == null)
                      const MessageWidget(text: 'No trailer evidences'),
                    ],
                  ),
                ),
              ),
            ),

            /// --> Damages evidences.
            SectionWidget(
              title: 'Damages', 
              outterPadding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: <Widget>[
                      if(damage1 != null)
                      ImageViewer(
                        resource: damage1, 
                      ),
                  
                      if(damage2 != null)
                      ImageViewer(
                        resource: damage2, 
                      ),
                  
                      if(damage1 == null && damage2 == null)
                      const MessageWidget(text: 'No damages evidences'),
                    ],
                  ),
                ),
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
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              const SectionDivider(text: 'Yardlog details'),
              OptionsSelector<bool>(
                title: 'Event',
                preSelected: <bool>[entity.entry],
                options:  <OptionsSelectorOption<bool>>[
                  OptionsSelectorOption<bool>(
                    title: 'In',
                    value: true,
                  ),
                  OptionsSelectorOption<bool>(
                    title: 'Out',
                    value: false,
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
                label: '*Select a Driver...',
                initialValue: entity.driver,
                textBuilder: (DriverCommon driver) {
                  return "${driver.name} - ${driver.license}";
                },
                onSelected: (DriverCommon? driver) {
                  entity.driver = driver ?? DriverCommon();
                },
              ),
              EntityFinderSelector<TruckCommon, TrucksServiceI>(
                entityBuilder: () => TruckCommon(),
                label: '*Select a Truck...',
                initialValue: entity.truck,
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
                initialValue: entity.trailer,
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
                hint: 'Enter the From/To information',
                onChanged: (String value) => entity.fromTo = value,
                controller: TextEditingController(
                  text: entity.fromTo,
                ),
              ),

              /// Truck evidences section.
              SectionWidget(
                outterPadding: EdgeInsets.zero,
                title: '*Truck evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    ReactiveWidget<_TruckFrontState>(
                      reactor: _truckFrontState,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _truckFrontReact = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.truckFrontRes);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.truckFrontSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.truckFrontRes));
                        _truckFrontReact();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.truckFrontRes, entity);
                        _truckFrontReact();
                      },  
                    ),

                    ReactiveWidget<_TruckLateralState>(
                      reactor: _truckLateralState,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _truckLateralReact = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.truckLateralRes);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.truckLateralSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.truckLateralRes));
                        _truckLateralReact(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.truckLateralRes, entity);
                        _truckLateralReact(); 
                      },  
                    ),
                  ],
                ),
              ),

              /// --> Trailer evidence section.
              SectionWidget(
                outterPadding: EdgeInsets.zero,
                title: 'Trailer evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    ReactiveWidget<_TrailerBackState>(
                      reactor: _trailerBackState,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _trailerBackReact = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.trailerBackRes);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.trailerBackSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.trailerBackRes));
                        _trailerBackReact();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.trailerBackRes, entity);
                        _trailerBackReact();
                      },  
                    ),
                    
                    ReactiveWidget<_TrailerLateralState>(
                      reactor: _trailerLateralState,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _trailerLateralReact = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.trailerLateralRes);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.trailerLateralSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.trailerLateralRes));
                        _trailerLateralReact(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.trailerLateralRes, entity);
                        _trailerLateralReact(); 
                      },  
                    ),
                  ],
                ),
              ),

              /// --> Damage evidence section.
              SectionWidget(
                outterPadding: EdgeInsets.zero,
                title: 'Damage evidences',
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    ReactiveWidget<_Damage1State>(
                      reactor: _damage1State,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _damage1React = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.damage1Res);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.damagedSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.damage1Res));
                        _damage1React();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.damage1Res, entity);
                        _damage1React();
                      },  
                    ),
                    ReactiveWidget<_Damage2State>(
                      reactor: _damage2State,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _damage2React = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.damage2Res);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.damagedSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.damage2Res));
                        _damage2React(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.damage2Res, entity);
                        _damage2React(); 
                      },  
                    ),
                  ],
                ),
              ),

              SectionWidget(
                outterPadding: EdgeInsets.zero,
                title: 'Seals',
                child: Column(
                  spacing: 10,
                  children: <Widget>[ 

                    ///* --> First Seal
                    TextInput(
                      width: double.maxFinite,
                      maxLength: 64,
                      label: 'Seal #1',
                      hint: 'Seal number',
                      onChanged: (String value) => entity.sanitize(seal: value),
                      controller: TextEditingController(
                        text: entity.seal,
                      ),
                    ),
                    ReactiveWidget<_Seal1State>(
                      reactor: _seal1State,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _seal1React = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.seal1Res);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.sealSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.seal1Res));
                        _seal1React();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.seal1Res, entity);
                        _seal1React();
                      },  
                    ),

                    ///* --> Second Seal
                    TextInput(
                      width: double.maxFinite,
                      maxLength: 64,
                      label: 'Seal #2',
                      hint: 'Seal number',
                      onChanged: (String value) => entity.sanitize(sealAlt: value),
                      controller: TextEditingController(
                        text: entity.sealAlt,
                      ),
                    ),
                    ReactiveWidget<_Seal2State>(
                      reactor: _seal2State,
                      builder: (BuildContext ctx, ReactorI reactor) {
                        _seal2React = reactor.react;
                        Resource? resource = entity.getResource(FoundationReferences.seal2Res);
                        if(resource != null) {
                          return ImageViewer(
                            resource: resource,
                          );
                        }
                        return _BlendedSVG(route: FoundationAssets.sealSvg);
                      },
                    ),
                    FileSelector(
                      dialogTitle: 'Select a damage image',
                      fileType: FileType.image,
                      onRemove:() {
                        entity.resources.removeAt(entity.getIndexResource(FoundationReferences.seal2Res));
                        _seal2React(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.seal2Res, entity);
                        _seal2React(); 
                      },  
                    ),
                  ],
                ),
              ),

              SectionWidget(
                outterPadding: EdgeInsets.zero,
                title: 'Section', 
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    EntityFinderSelector<Section, SectionsServiceI>(
                      label: '*Section',
                      entityBuilder: () => Section(),
                      initialValue: entity.section,
                      textBuilder: (Section section) {
                        return section.name;
                      },
                      onSelected: (Section? selSection) {
                        entity.section = selSection ?? Section();
                        _sectionReact();
                      } 
                    ),
                    ReactiveWidget<_SectionState>(
                      reactor: _sectionState,
                      builder: (BuildContext ctx, _SectionState reactor) {
                        _sectionReact = reactor.react;
                        if (entity.section != null && (entity.section!.id > BigInt.zero && entity.section!.resource != null)){
                          return  ImageViewer(
                            resource: entity.section!.resource!,
                          );
                        }

                        if (entity.section != null && (entity.section!.id > BigInt.zero && entity.section!.resource == null)) {
                          return  const Center(
                            child: MessageWidget(
                              text: 'Not section image to show.',
                            ),
                          );
                        }

                        return _BlendedSVG(
                          route: FoundationAssets.yardPlaceholderSvg,
                        );
                      },
                    ), 
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
          value: entity.section != null? '${entity.section!.yard.name} - ${entity.section!.name}' : '---',
        ),
      ],
    );
  }

  void _setResource(List<XFile> xFiles, String reference, YardLog entity) async {
    Resource resource = Resource();
    resource.file = await xFiles.first.readAsBytes();
    resource.name = reference;
    resource.extension = xFiles.first.name.split('.').last;
    entity.setResource(resource, replaceOnRef: reference);
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
          factory: (YardLog entity, int index, BuildContext buildContext) =>  entity.section?.name ?? '---',
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
