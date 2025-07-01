part of 'yardlogs_page_create_whisper.dart';

/// {widget} {private} class.
///
/// Draws and handles the [TruckCommon] selection section for [YardLogsPageCreateWhisper].
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
            EntityFinderSelector<TruckCommon, Trucks>(
              entityBuilder: () => TruckCommon(),
              label: 'Select a Truck...',
              enabled: externalTruck == null,
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
                      /// --> License
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: _kMinInputWidth,
                        ),
                        child: TextInput(
                          maxLength: 12,
                          label: 'License',
                          deBounce: _kDefaultInputDebounce,
                          isFixedLength: true,
                          onChanged: (String text) {
                            if (externalTruck == null) return;
                          },
                        ),
                      ),

                      /// --> Name & LastName
                      _SpacedWrap(
                        children: <Widget>[
                          /// --> Name
                          TextInput(
                            label: 'Name',
                            width: inputWidth,
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTruck == null) return;
                            },
                          ),

                          /// --> Last Name
                          TextInput(
                            width: inputWidth,
                            label: 'Last Name',
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTruck == null) return;
                            },
                          ),
                        ],
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
