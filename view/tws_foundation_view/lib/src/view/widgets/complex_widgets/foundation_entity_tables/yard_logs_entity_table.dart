import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_client_core/csm_client_core.dart';
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
import 'package:tws_foundation_view/src/view/widgets/section_divider.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Damage state class.
class _Damage1State extends ReactorBase {}
_Damage1State _damage1State = _Damage1State();
void Function() _damage1React = () {};

class _Damage2State extends ReactorBase {}
_Damage2State _damage2State = _Damage2State();
void Function() _damage2React = () {};

class _TruckFrontState extends ReactorBase {}
_TruckFrontState _truckFrontState = _TruckFrontState();
void Function() _truckFrontReact = () {};

class _TruckLateralState extends ReactorBase {}
_TruckLateralState _truckLateralState = _TruckLateralState();
void Function() _truckLateralReact = () {};

class _TrailerBackState extends ReactorBase {}
_TrailerBackState _trailerBackState = _TrailerBackState();
void Function() _trailerBackReact = () {};

class _TrailerLateralState extends ReactorBase {}
_TrailerLateralState _trailerLateralState = _TrailerLateralState();
void Function() _trailerLateralReact = () {};

class _Seal1State extends ReactorBase {}
_Seal1State _seal1State = _Seal1State();
void Function() _seal1React = () {};

class _Seal2State extends ReactorBase {}
_Seal2State _seal2State = _Seal2State();
void Function() _seal2React = () {};

class _SectionState extends ReactorBase {}
_SectionState _sectionState = _SectionState();
void Function() _sectionReact = () {};

class _BlendedSVG extends StatelessWidget {
  final String route;
  const _BlendedSVG({
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    FoundationThemeB theme = ThemingUtils.get<FoundationThemeB>(context);
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

  /// Stores the reservation yardlog only for the reservations view.
  YardLog? selectedReservation;

  /// Indicates if the table is being used for reservations management, this is used to show/hide some properties at the viewer and editor.
  bool isResevation;

  /// Creates a new [YardLogsEntityTableAdapter] instance.
  YardLogsEntityTableAdapter({
    super.authBuilder,
    this.isResevation = false,
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
            PropertyViewer<String>(
              label: 'Timestamp',
              value: entity.timestamp.fullDate,
            ),

            /// --> Reservation property view.
            PropertyViewer<String>(
              label: 'Reservation', 
              value: entity.reservation? 'Yes' : 'No',
            ),

            /// --> Event property view.
            PropertyViewer<String>(
              label: 'Event',
              value: entity.entry ? 'In' : 'Out',
            ),

            PropertyViewer<String>(
              label: 'Guard', 
              value: entity.guard?.fullName,
            ),

            /// --> Load Type property view.
            PropertyViewer<String>(
              label: 'Load Type',
              value: entity.loadType.name,
            ),

            /// --> From/To property view.
            PropertyViewer<String>(
              label: entity.entry? 'From' : 'To',
              value: entity.fromTo,
            ),
            
            /// --> Section property view.
            PropertyViewer<String>(
              label: 'Section',
              value: entity.section != null? '${entity.section!.yard.name} - ${entity.section!.name}' : '---',
            ),
            
            /// --> Driver section
            const SectionDivider(text: 'Driver'),
            /// --> Driver name property view.
            PropertyViewer<String>(
              label: 'Name',
              value: entity.driver.name,
            ),

            /// --> Driver licence property view.
            PropertyViewer<String>(
              label: 'Licence',
              value: entity.driver.license,
            ),
            /// --> Truck section
            const SectionDivider(text: 'Truck'),
            /// --> Truck economic property view.
            PropertyViewer<String>(
              label: 'Economic',
              value: entity.truck.economic,
            ),

            /// --> Truck plates property view.
            PropertyViewer<String>(
              label: 'Plates',
              value: entity.truck.plates,
            ),

            /// --> Truck carrier property view.
            PropertyViewer<String>(
              label: 'Carrier',
              value: entity.truck.carrier,
            ),
            /// --> Trailer type section.
            if(entity.trailer != null)
            ...<Widget>[
              const SectionDivider(text: 'Trailer'),
              /// --> Trailer economic property view.
              PropertyViewer<String>(
                label: 'Economic',
                value: entity.trailer?.economic,
              ),

              /// --> Trailer plates property view.
              PropertyViewer<String>(
                label: 'Plates',
                value: entity.trailer?.plates,
              ),

              /// --> Trailer type property view.
              PropertyViewer<String>(
                label: 'Type',
                value: entity.trailer?.classType,
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
                      PropertyViewer<String>(
                        label: 'Seal #1',
                        value: entity.seal,
                      ),
                  
                      if(seal1 != null)
                      ImageViewer(
                        resource: seal1, 
                      ),
                  
                      /// --> Second seal property view.
                      PropertyViewer<String>(
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
      onUpdate: (EntityTableAdapterEditorData<YardLog> data) {
        final Router router = InjectorUtils.get();

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(data.entity, router, context),
        );
      }, 
      formBuilder:(EntityTableAdapterEditorData<YardLog> data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              const SectionDivider(text: 'Yardlog details'),
              OptionsSelector<bool>(
                title: 'Event',
                preSelected: <bool>[data.entity.entry],
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
                  data.entity.entry = selected.firstOrNull ?? false;
                },
              ),
              // --> Load Type Selection.
              // CatalogOptionsSelector<LoadType, LoadTypesServiceI>(
              //   title: 'Load Type',
              //   entityBuilder: () => LoadType(),
              //   onSelect: (List<LoadType> selection) => entity.loadType = selection[0],
              // ),

              EntityFinderSelector<LoadType, LoadTypesServiceI>(
                entityBuilder: () => LoadType(),
                label: 'Select the load type...',
                initialValue: data.entity.loadType,
                filterBy: <String>[
                  CorePropertiesConsts.name,
                ],
                textBuilder: (LoadType loadtype) {
                  return loadtype.name;
                },
                onSelected: (LoadType? loadtype) {
                  data.entity.loadType = loadtype ?? LoadType();
                },
              ),
              
              /// --> Driver selection.
              EntityFinderSelector<DriverCommon, DriversServiceI>(
                entityBuilder: () => DriverCommon(),
                label: '*Select a Driver...',
                initialValue: data.entity.driver,
                filterBy: <String>[
                  DriverCommon.kLicense.toStartUpper,
                  '${CorePropertiesConsts.internal}.${Driver.kEmployee}.${Employee.kIdentification}.${CorePropertiesConsts.name}',
                  '${CorePropertiesConsts.external}.${DriverExternal.kIdentification}.${CorePropertiesConsts.name}',
                ],
                textBuilder: (DriverCommon driver) {
                  return "${driver.name} - ${driver.license}";
                },
                onSelected: (DriverCommon? driver) {
                  data.entity.driver = driver ?? DriverCommon();
                },
              ),
              EntityFinderSelector<TruckCommon, TrucksServiceI>(
                entityBuilder: () => TruckCommon(),
                label: '*Select a Truck...',
                initialValue: data.entity.truck,
                filterBy: <String>[
                  TruckCommon.kEconomic,
                ],
                textBuilder: (TruckCommon truck) {
                  return truck.economic;
                },
                onSelected: (TruckCommon? truck) {
                  data.entity.truck = truck ?? TruckCommon();
                },
              ),
              EntityFinderSelector<TrailerCommon, TrailersServiceI>(
                entityBuilder: () => TrailerCommon(),
                label: 'Select a Trailer...',
                initialValue: data.entity.trailer,
                filterBy: <String>[
                  TrailerCommon.kEconomic,
                ],
                textBuilder: (TrailerCommon trailer) {
                  return trailer.economic;
                },
                onSelected: (TrailerCommon? trailer) {
                  data.entity.trailer = trailer;
                },
              ),

              TextInput(
                width: double.maxFinite,
                maxLength: 100,
                label: data.entity.entry ? '*From' : '*To',
                hint: 'Enter the From/To information',
                onChanged: (String value) => data.entity.fromTo = value,
                controller: TextEditingController(
                  text: data.entity.fromTo,
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
                      builder: (BuildContext ctx, IReactor reactor) {
                        _truckFrontReact = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.truckFrontRes);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.truckFrontRes));
                        _truckFrontReact();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.truckFrontRes, data.entity);
                        _truckFrontReact();
                      },  
                    ),

                    ReactiveWidget<_TruckLateralState>(
                      reactor: _truckLateralState,
                      builder: (BuildContext ctx, IReactor reactor) {
                        _truckLateralReact = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.truckLateralRes);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.truckLateralRes));
                        _truckLateralReact(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.truckLateralRes, data.entity);
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
                      builder: (BuildContext ctx, IReactor reactor) {
                        _trailerBackReact = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.trailerBackRes);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.trailerBackRes));
                        _trailerBackReact();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.trailerBackRes, data.entity);
                        _trailerBackReact();
                      },  
                    ),
                    
                    ReactiveWidget<_TrailerLateralState>(
                      reactor: _trailerLateralState,
                      builder: (BuildContext ctx, IReactor reactor) {
                        _trailerLateralReact = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.trailerLateralRes);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.trailerLateralRes));
                        _trailerLateralReact(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.trailerLateralRes, data.entity);
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
                      builder: (BuildContext ctx, IReactor reactor) {
                        _damage1React = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.damage1Res);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.damage1Res));
                        _damage1React();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.damage1Res, data.entity);
                        _damage1React();
                      },  
                    ),
                    ReactiveWidget<_Damage2State>(
                      reactor: _damage2State,
                      builder: (BuildContext ctx, IReactor reactor) {
                        _damage2React = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.damage2Res);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.damage2Res));
                        _damage2React(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.damage2Res, data.entity);
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
                      onChanged: (String value) => data.entity.sanitize(seal: value),
                      controller: TextEditingController(
                        text: data.entity.seal,
                      ),
                    ),
                    ReactiveWidget<_Seal1State>(
                      reactor: _seal1State,
                      builder: (BuildContext ctx, IReactor reactor) {
                        _seal1React = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.seal1Res);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.seal1Res));
                        _seal1React();
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.seal1Res, data.entity);
                        _seal1React();
                      },  
                    ),

                    ///* --> Second Seal
                    TextInput(
                      width: double.maxFinite,
                      maxLength: 64,
                      label: 'Seal #2',
                      hint: 'Seal number',
                      onChanged: (String value) => data.entity.sanitize(sealAlt: value),
                      controller: TextEditingController(
                        text: data.entity.sealAlt,
                      ),
                    ),
                    ReactiveWidget<_Seal2State>(
                      reactor: _seal2State,
                      builder: (BuildContext ctx, IReactor reactor) {
                        _seal2React = reactor.react;
                        Resource? resource = data.entity.getResource(FoundationReferences.seal2Res);
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
                        data.entity.resources.removeAt(data.entity.getIndexResource(FoundationReferences.seal2Res));
                        _seal2React(); 
                      },
                      onSelect:(List<XFile> xFiles, _) async {
                        _setResource(xFiles, FoundationReferences.seal2Res, data.entity);
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
                      initialValue: data.entity.section,
                      filterBy: <String>[
                        CorePropertiesConsts.name,
                      ],
                      textBuilder: (Section section) {
                        return section.name;
                      },
                      onSelected: (Section? selSection) {
                        data.entity.section = selSection ?? Section();
                        _sectionReact();
                      } 
                    ),
                    ReactiveWidget<_SectionState>(
                      reactor: _sectionState,
                      builder: (BuildContext ctx, _SectionState reactor) {
                        _sectionReact = reactor.react;
                        if (data.entity.section != null && (data.entity.section!.id > BigInt.zero && data.entity.section!.resource != null)){
                          return  ImageViewer(
                            resource: data.entity.section!.resource!,
                          );
                        }

                        if (data.entity.section != null && (data.entity.section!.id > BigInt.zero && data.entity.section!.resource == null)) {
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
    YardLogsServiceI yardLogsService = InjectorUtils.get();

    List<EntityErrors<YardLog>> invalidations = entity.evaluate(<EntityErrors<YardLog>>[]);

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
      factory:
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
        Navigator.of(context).pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating Yard log',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: ThemingUtils.get<FoundationThemeB>(context).controlError,
              onAccept: () {
                Navigator.of(context).pop();
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
          value: entity.guard?.fullName ?? '---',
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
    return EntityTable<YardLog, ResponseResolverBase<ViewOutput<YardLog>>, YardLogsServiceI>(
      adapter: adapter,
      factory: () => YardLog(),
      columns: <EntityTableColumnData<YardLog>>[
        EntityTableColumnData<YardLog>(
          title: 'Entry',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.entry ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnData<YardLog>(
          title: 'Date',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.timestamp.toIso8601String(),
        ),
        EntityTableColumnData<YardLog>(
          title: 'Load Type',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.loadType.name,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Drivers License',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.license,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Driver',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.driver.name,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Truck Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.economic,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Truck Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.truck.plates,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Trailer Number',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.economic ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Trailer Plate',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.trailer?.plates ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Seal',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.seal,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Seal #2',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.sealAlt,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Origin - Destination',
          factory: (YardLog entity, int index, BuildContext buildContext) => entity.fromTo,
        ),
        EntityTableColumnData<YardLog>(
          title: 'Damaged',
          customFactory: (YardLog entity, int index, BuildContext buildContext) {
            return Icon(
              entity.getResource('damage') != null ? Icons.check : Icons.close,
            );
          },
        ),
        EntityTableColumnData<YardLog>(
          title: 'Section',
          factory: (YardLog entity, int index, BuildContext buildContext) =>  entity.section?.name ?? '---',
        ),
        EntityTableColumnData<YardLog>(
          title: 'Guard',
          factory: (YardLog entity, int index, BuildContext buildContext) {
            return entity.guard?.identification.fullname ?? '---';
          },
        ),
      ],
    );
  }
}
