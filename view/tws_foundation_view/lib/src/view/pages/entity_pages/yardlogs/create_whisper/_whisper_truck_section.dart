part of 'create_yardlogs_whisper.dart';

/// {constant} default plate related max length.
const int _kPlateMaxLength = 12;

/// {widget} {private} class.
///
/// Draws and handles the [TruckCommon] selection section for [CreateYardLogsWhisper].
final class _TruckSection extends StatefulWidget {
  /// {event} callback called when a [TruckCommon] is selected.
  ///
  ///
  /// [selTruck] selected [TruckCommon] instance, or created when applies.
  final void Function(TruckCommon selTruck) onSelection;

  /// Creates a new [_TruckSection] instance.
  const _TruckSection({
    required this.onSelection,
  });

  @override
  State<_TruckSection> createState() => _TruckSectionState();
}

/// {state} class.
///
/// Handles [State] for [_TruckSection].
final class _TruckSectionState extends State<_TruckSection> {
  /// {state} whether the section is handling a [TruckExternal] creation.
  TruckCommon? externalTruck;

  /// Initializes the necessary data and entities to handle [TruckExternal] creation.
  void initExternalTruckEntity() {
    externalTruck = TruckCommon();
    externalTruck!.external = TruckExternal();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: '*Truck',
      outterPadding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --> Truck selection.
            EntityFinderSelector<TruckCommon, TrucksServiceI>(
              entityBuilder: () => TruckCommon(),
              label: 'Select a Truck...',
              enabled: externalTruck == null,
              textBuilder: (TruckCommon truck) {
                return truck.economic;
              },
            ),

            /// --> External Truck Creation.
            FoldPanelWidget(
              title: 'Create External Truck',
              visible: externalTruck != null,
              onChange: (bool visible) {
                setState(() {
                  if (visible) {
                    initExternalTruckEntity();
                  } else {
                    externalTruck = null;
                  }
                });
              },
              child: LayoutBuilder(
                builder: (_, BoxConstraints boxConstraints) {
                  boxConstraints = boxConstraints.boxed();

                  double boxWidth = boxConstraints.maxWidth - _kDefSpacing;
                  double inputWidth = (boxWidth / 2);
                  if (inputWidth < _kMinInputWidth) {
                    inputWidth = _kMinInputWidth;
                  }

                  return _SpacedWrap(
                    children: <Widget>[
                      /// --> PLates
                      _SpacedWrap(
                        children: <Widget>[
                          /// --> MEX Plate
                          TextInput(
                            label: 'MEX Plate',
                            width: inputWidth,
                            maxLength: _kPlateMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTruck == null) return;

                              externalTruck!.external!.mxPlate = text;
                            },
                          ),

                          /// --> USA Plate
                          TextInput(
                            width: inputWidth,
                            label: 'USA Plate',
                            maxLength: _kPlateMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTruck == null) return;

                              externalTruck!.external!.usaPlate = text;
                            },
                          ),
                        ],
                      ),

                      /// --> Economic Number
                      TextInput(
                        maxLength: 16,
                        label: 'Economic Number',
                        deBounce: _kDefaultInputDebounce,
                        onChanged: (String text) {
                          if (externalTruck == null) return;

                          externalTruck!.economic = text;
                        },
                      ),

                      /// --> Carrier
                      TextInput(
                        maxLength: 100,
                        label: 'Carrier',
                        deBounce: _kDefaultInputDebounce,
                        onChanged: (String text) {
                          if (externalTruck == null) return;

                          externalTruck!.external!.carrier = text;
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
