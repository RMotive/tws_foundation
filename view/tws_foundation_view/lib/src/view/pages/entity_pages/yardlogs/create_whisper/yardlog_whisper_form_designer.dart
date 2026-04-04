part of 'create_yardlogs_whisper.dart';
/// {form designer} class.
///
/// Draws the form designer for [CreateYardLogsWhisper] , providing the necessary sections and fields to correctly create [YardLog] entities.
class YardlogWhisperFormDesigner extends StatelessWidget {
  final FoundationThemeB theme;
  final CreateEntityFormRecordReactor<YardLog>? itemState;
  final bool isReservation;

  const YardlogWhisperFormDesigner({
    super.key,
    required this.theme,
    required this.itemState,
    required this.isReservation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              itemState?.entity.entry = selected.first;
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
            initialValue: itemState?.entity.loadType,
            filterBy: <String>[
              CorePropertiesConsts.name,
            ],
            textBuilder: (LoadType loadtype) {
              return loadtype.name;
            },
            onSelected: (LoadType? loadtype) {
              itemState?.entity.loadType = loadtype ?? LoadType();
              itemState?.react();
            },
          ),

          /// --> Driver selection.
          _DriversSection(
            onSelection: (DriverCommon selDriver) => itemState?.entity.driver = selDriver,
          ),

          /// --> Truck selection.
          _TruckSection(
            onSelection: (TruckCommon selTruck) => itemState?.entity.truck = selTruck,
          ),

          /// --> Trailer selection.
          _TrailerSection(
            onSelection: (TrailerCommon selTrailer) => itemState?.entity.trailer = selTrailer,
          ),

          TextInput(
            width: double.maxFinite,
            maxLength: 100,
            label: itemState?.entity.entry == true ? '*Origen' : '*Destino',
            hint: 'Ingresar información de origen/destino',
            onChanged: (String value) => itemState?.entity.fromTo = value,
            controller: TextEditingController(
              text: itemState?.entity.fromTo,
            ),
          ),

          if(!isReservation)
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
                                final Resource? resource = itemState?.entity.getResource(
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
                            itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.truckFrontRes);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconPhotoTaker(
                          resourceRoute: FoundationAssets.truckLateralSvg,
                          preLoad:
                              (() {
                                // Preload existing photo if any.
                                final Resource? resource = itemState?.entity.getResource(
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
                            itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.truckLateralRes);
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
                                final Resource? resource = itemState?.entity.getResource(
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
                            itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.trailerBackRes);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconPhotoTaker(
                          resourceRoute: FoundationAssets.trailerLateralSvg,
                          preLoad:
                              (() {
                                // Preload existing photo if any.
                                final Resource? resource = itemState?.entity.getResource(
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
                            itemState?.entity.setResource(
                              resource,
                              replaceOnRef: FoundationReferences.trailerLateralRes,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if(!isReservation)
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
                            final Resource? resource = itemState?.entity.getResource(
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
                        itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.damage1Res);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconPhotoTaker(
                      resourceRoute: FoundationAssets.damagedSvg,
                      preLoad:
                          (() {
                            // Preload existing photo if any.
                            final Resource? resource = itemState?.entity.getResource(
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
                        itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.damage2Res);
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
                          onChanged: (String value) => itemState?.entity.sanitize(seal: value),
                          controller: TextEditingController(
                            text: itemState?.entity.seal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextInput(
                          maxLength: 64,
                          label: 'Seal 2',
                          hint: 'Numero de sello 2',
                          onChanged: (String value) => itemState?.entity.sanitize(sealAlt: value),
                          controller: TextEditingController(
                            text: itemState?.entity.sealAlt,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if(!isReservation)
                  Row(
                    spacing: 10,
                    children: <Widget>[
                      Expanded(
                        child: IconPhotoTaker(
                          resourceRoute: FoundationAssets.sealSvg,
                          preLoad:
                              (() {
                                // Preload existing photo if any.
                                final Resource? resource = itemState?.entity.getResource(FoundationReferences.seal1Res);
                                if (resource != null) return XFile.fromData(resource.file);
                                return null;
                              })(),
                          onPhotoTaken: (XFile photo) async {
                            Resource resource = Resource();
                            resource.file = await photo.readAsBytes();
                            resource.name = FoundationReferences.seal1Res;
                            resource.extension = resource.file.resolveImageExtension;
                            itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.seal1Res);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconPhotoTaker(
                          resourceRoute: FoundationAssets.sealSvg,
                          preLoad:
                              (() {
                                // Preload existing photo if any.
                                final Resource? resource = itemState?.entity.getResource(FoundationReferences.seal2Res);
                                if (resource != null) return XFile.fromData(resource.file);
                                return null;
                              })(),
                          onPhotoTaken: (XFile photo) async {
                            Resource resource = Resource();
                            resource.file = await photo.readAsBytes();
                            resource.name = FoundationReferences.seal2Res;
                            resource.extension = resource.file.resolveImageExtension;
                            itemState?.entity.setResource(resource, replaceOnRef: FoundationReferences.seal2Res);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          if(!isReservation)
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
                    filterBy: <String>[
                      CorePropertiesConsts.name,
                    ],
                    textBuilder: (Section section) {
                      return section.name;
                    },
                    onSelected: (Section? selSection) {
                      itemState?.entity.section = selSection ?? Section();
                      _sectionReact();
                    },
                  ),

                  ReactiveWidget<_SectionState>(
                    reactor: _sectionState,
                    builder: (BuildContext ctx, _SectionState reactor) {
                      _sectionReact = reactor.react;
                      if (itemState?.entity.section != null &&
                          (itemState!.entity.section!.id > BigInt.zero &&
                              itemState?.entity.section!.resource != null)) {
                        return ImageViewer(
                          resource: itemState!.entity.section!.resource!,
                        );
                      }

                      if (itemState?.entity.section != null &&
                          (itemState!.entity.section!.id > BigInt.zero &&
                              itemState!.entity.section!.resource == null)) {
                        return const Center(
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
    );
  }
}
