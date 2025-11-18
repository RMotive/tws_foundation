part of 'create_yardlogs_whisper.dart';

/// {widget} {private} class.
///
/// Draws and handles the [TrailerCommon] selection section for [CreateYardLogsWhisper].
final class _TrailerSection extends StatefulWidget {
  /// {event} called when a trailer is selected.
  ///
  ///
  /// [selTrailer] selected trailer instance, or created instance when applies.
  final void Function(TrailerCommon selTrailer)? onSelection;

  /// Creates a new [_TrailerSection] instance.
  const _TrailerSection({
    this.onSelection,
  });

  @override
  State<_TrailerSection> createState() => _TrailerSectionState();
}

/// {state} class.
///
/// Handles [State] for [_TrailerSectionState].
final class _TrailerSectionState extends State<_TrailerSection> {
  /// {state} whether the section is handling a [DriverExternal] creation.
  TrailerCommon? externalTrailer;

  /// Initializes the necessary data and entities to handle [DriverExternal] creation.
  void initExternalTrailerEntity() {
    externalTrailer = TrailerCommon();
    externalTrailer!.external = TrailerExternal();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: '*Trailer',
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
            /// --> Trailer selection.
            EntityFinderSelector<TrailerCommon, TrailersServiceI>(
              entityBuilder: () => TrailerCommon(),
              textBuilder: (TrailerCommon trailer) {
                return trailer.economic;
              },
              label: 'Select a Trailer...',
              enabled: externalTrailer == null,
              onSelected: (TrailerCommon? trailer) {
                widget.onSelection?.call(trailer ?? TrailerCommon());
              },
            ),

            /// --> External Trailer Creation.
            FoldPanelWidget(
              title: 'Create External Trailer',
              visible: externalTrailer != null,
              onChange: (bool visible) {
                setState(() {
                  if (visible) {
                    initExternalTrailerEntity();
                  } else {
                    externalTrailer = null;
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
                      /// --> Economic Number & Carrier
                      _SpacedWrap(
                        children: <Widget>[
                          /// --> Economic Number
                          TextInput(
                            maxLength: 16,
                            width: inputWidth,
                            label: 'Economic Number',
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTrailer == null) return;

                              externalTrailer!.economic = text;
                            },
                          ),

                          /// --> Carrier
                          TextInput(
                            width: inputWidth,
                            label: 'Carrier',
                            maxLength: 100,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTrailer == null) return;

                              externalTrailer!.external!.carrier = text;
                            },
                          ),
                        ],
                      ),
                      

                      /// --> Plates (USA / MEX)
                      _SpacedWrap(
                        children: <Widget>[
                          /// --> MEX Plate
                          TextInput(
                            label: 'MEX Plate',
                            width: inputWidth,
                            maxLength: _kPlateMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTrailer == null) return;

                              externalTrailer!.external!.mxPlate = text;
                            },
                          ),

                          /// --> USA Plate
                          TextInput(
                            width: inputWidth,
                            label: 'USA Plate',
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalTrailer == null) return;

                              externalTrailer!.external!.usaPlate = text;
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
