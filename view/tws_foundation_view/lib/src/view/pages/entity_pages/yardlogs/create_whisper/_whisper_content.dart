part of 'create_yardlogs_whisper.dart';

/// State manager for Section fields.
class _SectionState extends ReactorB {}
_SectionState _sectionState = _SectionState();
void Function() _sectionReact = () {};

/// Draws and handles the content for [CreateYardLogsWhisper], drawing each necessary
/// section and gathering required information to correctly create [YardLog] entities.
final class _CreateYardLogsWhisperContent extends StatefulWidget {
  /// Whether the created yardlog is a reservation or not.
  final bool isResevation;

  /// Creation {event} controller.
  final CreateEntityFormController controller;
  
  /// Create a new [_CreateYardLogsWhisperContent] instance.
  const _CreateYardLogsWhisperContent({
    required this.controller,
    required this.isResevation,
  });

  @override
  State<_CreateYardLogsWhisperContent> createState() => _CreateYardLogsWhisperContentState();
}

/// Handles [State] for [_CreateYardLogsWhisperContent].
final class _CreateYardLogsWhisperContentState extends State<_CreateYardLogsWhisperContent> {

  /// {state} Instance of the current theming.
  late FoundationThemeB theme;

  /// {state} stores the last [_getUserData] invokation.
  late final Future<Employee?> _getUserEmployeeInstance = _getUserData();
  
  /// {state} stores the default entity status.
  late final Status? defStatus;

  /// {state} guard who's creating the yardlog(s).
  late final Employee? guard;

  @override
  void didChangeDependencies() {
    theme = Theming.get<FoundationThemeB>(context);
    super.didChangeDependencies();
  }

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<Employee?> _getUserData() async {
    SessionStorageI sessionStorage = Injector.get();
    EmployeesServiceI employeesService = Injector.get();
    StatusesServiceI statusService = Injector.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

    FoundationResponseResolver<Status?> statusResponseResolver = await statusService.read(FoundationReferences.statusActive,token);

    defStatus = statusResponseResolver.resolveDirect(() => Status());

    guard = responseResolver.resolveDirect(
      () => Employee(),
    );

    return guard;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<Employee?>(
      future: _getUserEmployeeInstance,
      successBuilder: (BuildContext buildContext, Employee? data) {
        if (data == null) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: ErrorMessageWidget(
                message: 'You need to be an Employee to create YardLog(s)',
              ),
            ),
          );
        }

        return CreateEntityForm<YardLog, YardLogsServiceI>(
          isMultiple: false,
          controller: widget.controller,
          entityFactory: () {
            YardLog log = YardLog();
            log.guard = guard!;
            return log;
          },
          buildEntityTag: (YardLog entity) {
            return 'Yardlog with: ${entity.driver.name} and truck ${entity.truck.economic}';
          },
          formDesigner: (CreateEntityFormRecordReactor<YardLog>? itemState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  children: <Widget>[
                    /// --> YardLog Entry
                    OptionsSelector<bool>(
                      height: 200,
                      fontSize: 100,
                      title: 'Evento',
                      preSelected: <bool>[itemState!.entity.entry],
                      options: <OptionsSelectorOption<bool>>[
                        OptionsSelectorOption<bool>(
                          title: 'Entrada',
                          value: true,
                          resource: FoundationAssets.exitSvg,
                        ),
                        OptionsSelectorOption<bool>(
                          title: 'Salida',
                          value: false,
                          resource: FoundationAssets.exitSvg,
                          iconRotation: 2,
                        ),
                      ],
                      onSelect: (List<bool> selected) {
                        itemState.entity.entry = selected.first;
                      },
                    ),

                    // --> Load Type Selection.
                    // CatalogOptionsSelector<LoadType, LoadTypesServiceI>(
                    //   title: 'Load Type',
                    //   entityBuilder: () => LoadType(),
                    //   onSelect: (List<LoadType> selection) => entity.loadType = selection[0],
                    // ),

                    // --> Load Type Selection.
                    EntityFinderSelector<LoadType, LoadTypesServiceI>(
                      entityBuilder: () => LoadType(),
                      label: 'Select the load type...',
                      initialValue: itemState.entity.loadType,
                      textBuilder: (LoadType loadtype) {
                        return loadtype.name;
                      },
                      onSelected: (LoadType? loadtype) {
                        itemState.entity.loadType = loadtype ?? LoadType();
                        itemState.react();
                      },
                    ),
                    /// --> Driver selection.
                    _DriversSection(
                      onSelection: (DriverCommon selDriver) => itemState.entity.driver = selDriver,
                    ),

                    /// --> Truck selection.
                    _TruckSection(
                      onSelection: (TruckCommon selTruck) => itemState.entity.truck = selTruck,
                    ),

                    /// --> Trailer selection.
                    _TrailerSection(
                      onSelection: (TrailerCommon selTrailer) => itemState.entity.trailer = selTrailer,
                    ),

                    TextInput(
                      width: double.maxFinite,
                      maxLength: 100,
                      label: itemState.entity.entry ? '*Origen' : '*Destino',
                      hint: 'Ingresar información de origen/destino',
                      onChanged: (String value) => itemState.entity.fromTo = value,
                      controller: TextEditingController(
                        text: itemState.entity.fromTo,
                      ),
                    ),

                    SectionWidget(
                      title: "Fotos del camión y remolque", 
                      outterPadding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 10,
                          children: <Widget>[
                            //* --> Truck Section
                            Row(
                              spacing: 10,
                              children: <Widget>[
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.truckFrontSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(
                                            FoundationReferences.truckFrontRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.truckFrontRes;
                                      resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.truckFrontRes);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.truckLateralSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(
                                            FoundationReferences.truckLateralRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.truckLateralRes;
                                      resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.truckLateralRes);
                                    },
                                  ),
                                ),
                              ],
                            ),

                            //* --> Trailer Section
                            Row(
                              spacing: 10,
                              children: <Widget>[
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.trailerBackSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(
                                            FoundationReferences.trailerBackRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.trailerBackRes;
                                      resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.trailerBackRes);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.trailerLateralSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(
                                            FoundationReferences.trailerLateralRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.trailerLateralRes;
                                      resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.trailerLateralRes);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SectionWidget(
                      title: "Daños",
                      outterPadding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 10,
                          children: <Widget>[
                            Expanded(
                              child: IconPhotoTaker(
                                resourceRoute: FoundationAssets.damagedSvg,
                                preLoad:
                                    (() {
                                      // Preload existing photo if any.
                                      final Resource? resource = itemState.entity.getResource(
                                        FoundationReferences.damage1Res,
                                      );
                                      if (resource != null) return XFile.fromData(resource.file);
                                      return null;
                                    })(),
                                onPhotoTaken: (XFile photo) async {
                                  Resource resource = Resource();
                                  resource.file = await photo.readAsBytes();
                                  resource.name = FoundationReferences.damage1Res;
                                   if (photo.mimeType != null) {
                                    resource.extension = photo.mimeType!.split('/').last;
                                  }
                                  itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                                },
                              ),
                            ),
                            Expanded(
                              child: IconPhotoTaker(
                                resourceRoute: FoundationAssets.damagedSvg,
                                preLoad:
                                    (() {
                                      // Preload existing photo if any.
                                      final Resource? resource = itemState.entity.getResource(
                                        FoundationReferences.damage2Res,
                                      );
                                      if (resource != null) return XFile.fromData(resource.file);
                                      return null;
                                    })(),
                                onPhotoTaken: (XFile photo) async {
                                  Resource resource = Resource();
                                  resource.file = await photo.readAsBytes();
                                  resource.name = FoundationReferences.damage2Res;
                                  resource.extension = resource.file.resolveImageExtension; 
                                  itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.damage2Res);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// --> Seal information.
                    SectionWidget(
                      title: 'Sellos', 
                      outterPadding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 10,
                          children: <Widget>[
                            Row(
                              spacing: 10,
                              children: <Widget>[
                                Expanded(
                                  child: TextInput(
                                    maxLength: 64,
                                    label: 'Sello 1',
                                    hint: 'Numero de sello 1',
                                    onChanged: (String value) => itemState.entity.sanitize(seal: value),
                                    controller: TextEditingController(
                                      text: itemState.entity.seal,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextInput(
                                    maxLength: 64,
                                    label: 'Seal 2',
                                    hint: 'Numero de sello 2',
                                    onChanged: (String value) => itemState.entity.sanitize(sealAlt: value),
                                    controller: TextEditingController(
                                      text: itemState.entity.sealAlt,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        
                            Row(
                              spacing: 10,
                              children: <Widget>[
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.sealSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(FoundationReferences.seal1Res);
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.seal1Res;
                                      resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.seal1Res);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:  IconPhotoTaker(
                                    resourceRoute: FoundationAssets.sealSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState.entity.getResource(FoundationReferences.seal2Res);
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.seal2Res;
                                       resource.extension = resource.file.resolveImageExtension; 
                                      itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.seal2Res);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    
                    SectionWidget(
                      title: 'Sección',
                      outterPadding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 10,
                          children: <Widget>[
                            EntityFinderSelector<Section, SectionsServiceI>(
                              label: 'Sección',
                              entityBuilder: () => Section(),
                              textBuilder: (Section section) {
                                return section.name;
                              },
                              onSelected: (Section? selSection) {
                                itemState.entity.section = selSection ?? Section();
                                _sectionReact();
                              } 
                            ),

                            ReactiveWidget<_SectionState>(
                              reactor: _sectionState,
                              builder: (BuildContext ctx, _SectionState reactor) {
                                _sectionReact = reactor.react;
                                if (itemState.entity.section != null && (itemState.entity.section!.id > BigInt.zero && itemState.entity.section!.resource != null)){
                                  return ImageViewer(
                                    resource: itemState.entity.section!.resource!,
                                  );
                                }

                                if (itemState.entity.section != null && (itemState.entity.section!.id > BigInt.zero && itemState.entity.section!.resource == null)) {
                                  return  const Center(
                                    child: MessageWidget(
                                      text: 'No hay una imagen disponible.',
                                    ),
                                  );
                                }

                                return SizedBox(
                                  height: 200,
                                  width: double.maxFinite,
                                  child: SvgPicture.asset(
                                    FoundationAssets.yardPlaceholderSvg,
                                    colorFilter: ColorFilter.mode(
                                      theme.page.fore,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                );
                              },
                            ), 
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
