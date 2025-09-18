part of 'create_yardlogs_whisper.dart';

/// Draws and handles the content for [CreateYardLogsWhisper], drawing each necessary
/// section and gathering required information to correctly create [YardLog] entities.
final class _CreateYardLogsWhisperContent extends StatefulWidget {
  /// Whether the created yardlog is a reservation or not.
  final bool isResevation;

  /// Create a new [_CreateYardLogsWhisperContent] instance.
  const _CreateYardLogsWhisperContent({
    required this.isResevation,
  });

  @override
  State<_CreateYardLogsWhisperContent> createState() => _CreateYardLogsWhisperContentState();
}

/// Handles [State] for [_CreateYardLogsWhisperContent].
final class _CreateYardLogsWhisperContentState extends State<_CreateYardLogsWhisperContent> {
  /// {state} stores the last [_getUserData] invokation.
  late final Future<Employee?> _getUserEmployeeInstance = _getUserData();
  
  /// {state} stores the default entity status.
  late final Status? defStatus;

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<Employee?> _getUserData() async {
    SessionStorageI sessionStorage = Injector.get();
    EmployeesServiceI employeesService = Injector.get();
    StatusesServiceI statusService = Injector.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);
    // FoundationResponseResolver<Status?> statusResponseResolver = await statusService.read(FoundationReferences.statusActive, token);

    // // TODO check nulls
    // defStatus = statusResponseResolver.resolveDirect(
    //   () => Status(),
    // );
    return responseResolver.resolveDirect(
      () => Employee(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<Employee?>(
      isStatic: true,
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

        return CreateEntityForm<YardLog>(
          isMultiple: false,
          entityFactory: () => YardLog(),
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
                        itemState!.entity.entry = selected.first;
                      },
                    ),

                    // --> Load Type Selection.
                    // CatalogOptionsSelector<LoadType, LoadTypesServiceI>(
                    //   title: 'Load Type',
                    //   entityBuilder: () => LoadType(),
                    //   onSelect: (List<LoadType> selection) => entity.loadType = selection[0],
                    // ),

                    /// --> Driver selection.
                    _DriversSection(
                      onSelection: (DriverCommon selDriver) => itemState!.entity.driver = selDriver,
                    ),

                    /// --> Truck selection.
                    _TruckSection(
                      onSelection: (TruckCommon selTruck) => itemState!.entity.truck = selTruck,
                    ),

                    /// --> Trailer selection.
                    _TrailerSection(
                      onSelection: (TrailerCommon selTrailer) => itemState!.entity.trailer = selTrailer,
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
                                          final Resource? resource = itemState!.entity.getResource(
                                            FoundationReferences.truckFrontRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.truckFrontRes;
                                      resource.extension = photo.path.split('.').last;
                                      itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.truckFrontRes);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.truckLateralSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState!.entity.getResource(
                                            FoundationReferences.truckLateralRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.truckLateralRes;
                                      resource.extension = photo.path.split('.').last;
                                      itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.truckLateralRes);
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
                                          final Resource? resource = itemState!.entity.getResource(
                                            FoundationReferences.trailerBackRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.trailerBackRes;
                                      resource.extension = photo.path.split('.').last;
                                      itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.trailerBackRes);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconPhotoTaker(
                                    resourceRoute: FoundationAssets.trailerLateralSvg,
                                    preLoad:
                                        (() {
                                          // Preload existing photo if any.
                                          final Resource? resource = itemState!.entity.getResource(
                                            FoundationReferences.trailerLateralRes,
                                          );
                                          if (resource != null) return XFile.fromData(resource.file);
                                          return null;
                                        })(),
                                    onPhotoTaken: (XFile photo) async {
                                      Resource resource = Resource();
                                      resource.file = await photo.readAsBytes();
                                      resource.name = FoundationReferences.trailerLateralRes;
                                      resource.extension = photo.path.split('.').last;
                                      itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.trailerLateralRes);
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
                                      final Resource? resource = itemState!.entity.getResource(
                                        FoundationReferences.damage1Res,
                                      );
                                      if (resource != null) return XFile.fromData(resource.file);
                                      return null;
                                    })(),
                                onPhotoTaken: (XFile photo) async {
                                  Resource resource = Resource();
                                  resource.file = await photo.readAsBytes();
                                  resource.name = FoundationReferences.damage1Res;
                                  resource.extension = photo.path.split('.').last;
                                  itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                                },
                              ),
                            ),
                            Expanded(
                              child: IconPhotoTaker(
                                resourceRoute: FoundationAssets.damagedSvg,
                                preLoad:
                                    (() {
                                      // Preload existing photo if any.
                                      final Resource? resource = itemState!.entity.getResource(
                                        FoundationReferences.damage2Res,
                                      );
                                      if (resource != null) return XFile.fromData(resource.file);
                                      return null;
                                    })(),
                                onPhotoTaken: (XFile photo) async {
                                  Resource resource = Resource();
                                  resource.file = await photo.readAsBytes();
                                  resource.name = FoundationReferences.damage2Res;
                                  resource.extension = photo.path.split('.').last;
                                  itemState!.entity.setResource(resource, replaceOnRef: FoundationReferences.damage2Res);
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
                                      text: itemState!.entity.seal,
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
                                      resource.extension = photo.path.split('.').last;
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
                                      resource.extension = photo.path.split('.').last;
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
                    
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(
                          child: TextInput(
                            width: double.maxFinite,
                            maxLength: 100,
                            label: itemState.entity.entry ? '*Origen' : '*Destino',
                            hint: 'Ingresar información de origen/destino',
                            onChanged: (String value) => itemState.entity.sanitize(sealAlt: value),
                            controller: TextEditingController(
                              text: itemState.entity.sealAlt,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: EntityFinderSelector<Section, SectionsService>(
                        //     label: 'Section',
                        //     entityBuilder: () => Section(),
                        //     onSelection: (Section selSection) => entity.section = selSection,
                        //   ),
                        // ),
                      ],
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
