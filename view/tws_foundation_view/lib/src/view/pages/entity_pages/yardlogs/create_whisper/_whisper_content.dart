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
  /// {state} stores the last [_getUserEmployee] invokation.
  late final Future<Employee?> _getUserEmployeeInstance = _getUserEmployee();

  /// Gets the current user [Employee] data (if there's) as required to generate a [YardLog].
  Future<Employee?> _getUserEmployee() async {
    SessionStorageI sessionStorage = Injector.get();
    EmployeesServiceI employeesService = Injector.get();

    String token = sessionStorage.token;

    FoundationResponseResolver<Employee?> responseResolver = await employeesService.getUserEmployee(token);

    return responseResolver.resolveDirect(
      () => Employee(),
    );
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

        return CreateEntityForm<YardLog>(
          isMultiple: false,
          entityFactory: () => YardLog(),
          formDesigner: (CreateEntityFormRecordReactor<YardLog>? itemState) {
            YardLog entity = itemState!.entity;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  children: <Widget>[
                    /// --> YardLog Entry
                    OptionsSelector<bool>(
                      height: 100,
                      fontSize: 30,
                      title: 'Evento',
                      options: <OptionsSelectorOption<bool>>[
                        OptionsSelectorOption<bool>(
                          title: 'Salida',
                          value: true,
                        ),
                        OptionsSelectorOption<bool>(
                          title: 'Entrada',
                          value: false,
                        ),
                      ],
                      onSelect: (List<bool> selected) {
                        entity.entry = selected.first;
                        setState(() {
                          
                        });
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
                      onSelection: (DriverCommon selDriver) => entity.driver = selDriver,
                    ),

                    /// --> Truck selection.
                    _TruckSection(
                      onSelection: (TruckCommon selTruck) => entity.truck = selTruck,
                    ),

                    /// --> Trailer selection.
                    _TrailerSection(
                      onSelection: (TrailerCommon selTrailer) => entity.trailer = selTrailer,
                    ),

                    SectionWidget(
                      title: "Fotos del camión y remolque", 
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
                                  child: SizedBox(
                                    child: IconPhotoTaker(
                                      svgRoute: FoundationAssets.truckFrontSvg,
                                      label: 'Frontal del camión',
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
                                        resource.extension = 'jpeg';
                                        itemState.entity.setResource(resource, replaceOnRef: FoundationReferences.truckFrontRes);
                                      },
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   child: IconPhotoTaker(
                                //     svgRoute: FoundationAssets.truckLateralSvg,
                                //     label: 'Lateral del camión',
                                //     preLoad:
                                //         (() {
                                //           // Preload existing photo if any.
                                //           final Resource? resource = entity.getResource(
                                //             FoundationReferences.truckLateralRes,
                                //           );
                                //           if (resource != null) return XFile.fromData(resource.file);
                                //           return null;
                                //         })(),
                                //     onPhotoTaken: (XFile photo) async {
                                //       Resource resource = Resource();
                                //       resource.file = await photo.readAsBytes();
                                //       resource.name = FoundationReferences.truckLateralRes;
                                //       resource.extension = 'jpeg';
                                //       entity.setResource(resource, replaceOnRef: FoundationReferences.truckLateralRes);
                                //       itemState.react();
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                            // Row(
                            //   spacing: 10,
                            //   children: <Widget>[
                            //     Expanded(
                            //       child: IconPhotoTaker(
                            //         svgRoute: FoundationAssets.trailerBackSvg,
                            //         label: 'Frontal del Trailer',
                            //         preLoad:
                            //             (() {
                            //               // Preload existing photo if any.
                            //               final Resource? resource = entity.getResource(
                            //                 FoundationReferences.trailerBackRes,
                            //               );
                            //               if (resource != null) return XFile.fromData(resource.file);
                            //               return null;
                            //             })(),
                            //         onPhotoTaken: (XFile photo) async {
                            //           Resource resource = Resource();
                            //           resource.file = await photo.readAsBytes();
                            //           resource.name = FoundationReferences.trailerBackRes;
                            //           resource.extension = 'jpeg';
                            //           entity.setResource(resource, replaceOnRef: FoundationReferences.trailerBackRes);
                            //           itemState.react();
                            //         },
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: IconPhotoTaker(
                            //         svgRoute: FoundationAssets.trailerLateralSvg,
                            //         label: 'Lateral del trailer',
                            //         preLoad:
                            //             (() {
                            //               // Preload existing photo if any.
                            //               final Resource? resource = entity.getResource(
                            //                 FoundationReferences.trailerLateralRes,
                            //               );
                            //               if (resource != null) return XFile.fromData(resource.file);
                            //               return null;
                            //             })(),
                            //         onPhotoTaken: (XFile photo) async {
                            //           Resource resource = Resource();
                            //           resource.file = await photo.readAsBytes();
                            //           resource.name = FoundationReferences.trailerLateralRes;
                            //           resource.extension = 'jpeg';
                            //           entity.setResource(resource, replaceOnRef: FoundationReferences.trailerLateralRes);
                            //           itemState.react();
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),

                    // SectionWidget(
                    //   title: "Daños",
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       spacing: 10,
                    //       children: <Widget>[
                    //         Expanded(
                    //           child: IconPhotoTaker(
                    //             svgRoute: FoundationAssets.damagedSvg,
                    //             label: 'Daño 1',
                    //             preLoad:
                    //                 (() {
                    //                   // Preload existing photo if any.
                    //                   final Resource? resource = entity.getResource(FoundationReferences.damage1Res);
                    //                   if (resource != null) return XFile.fromData(resource.file);
                    //                   return null;
                    //                 })(),
                    //             onPhotoTaken: (XFile photo) async {
                    //               Resource resource = Resource();
                    //               resource.file = await photo.readAsBytes();
                    //               resource.name = FoundationReferences.damage1Res;
                    //               resource.extension = 'jpeg';
                    //               entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                    //               itemState.react();
                    //             },
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: IconPhotoTaker(
                    //             svgRoute: FoundationAssets.damagedSvg,
                    //             label: 'Daño 2',
                    //             preLoad:
                    //                 (() {
                    //                   // Preload existing photo if any.
                    //                   final Resource? resource = entity.getResource(FoundationReferences.damage2Res);
                    //                   if (resource != null) return XFile.fromData(resource.file);
                    //                   return null;
                    //                 })(),
                    //             onPhotoTaken: (XFile photo) async {
                    //               Resource resource = Resource();
                    //               resource.file = await photo.readAsBytes();
                    //               resource.name = FoundationReferences.damage2Res;
                    //               resource.extension = 'jpeg';
                    //               entity.setResource(resource, replaceOnRef: FoundationReferences.damage2Res);
                    //               itemState.react();
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    /// --> Seal information.
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(
                          child: TextInput(
                            maxLength: 64,
                            label: 'Seal',
                            hint: 'Ingrese la información del sello',
                            onChanged: (String value) => entity.sanitize(seal: value),
                            controller: TextEditingController(
                              text: entity.seal,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextInput(
                            maxLength: 64,
                            label: 'Seal #2',
                            hint: 'Ingrese la información del sello',
                            onChanged: (String value) => entity.sanitize(sealAlt: value),
                            controller: TextEditingController(
                              text: entity.sealAlt,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(
                          child: TextInput(
                            width: double.maxFinite,
                            maxLength: 100,
                            label: entity.entry ? '*Origen' : '*Destino',
                            hint: 'Ingresar información de origen/destino',
                            onChanged: (String value) => entity.sanitize(sealAlt: value),
                            controller: TextEditingController(
                              text: entity.sealAlt,
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
