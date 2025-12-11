part of 'create_yardlogs_whisper.dart';

/// {constant} default naming related max length.
const int _kNamingMaxLength = 100;

/// {constant} default minimum [TextInput] width caluclable.
const double _kMinInputWidth = 75;

/// {constant} default [TextInput] debounce triggering timer.
const Duration _kDefaultInputDebounce = Duration(
  milliseconds: 400,
);

/// {widget} {private} class.
///
/// Draws and handles the [DriverCommon] selection section for [CreateYardLogsWhisper].
final class _DriversSection extends StatefulWidget {
  /// {event} called when a driver is selected.
  ///
  ///
  /// [selDriver] selected driver instance, or created instance when applies.
  final void Function(DriverCommon selDriver) onSelection;

  /// Creates a new [_DriversSection] instance.
  const _DriversSection({
    required this.onSelection,
  });

  @override
  State<_DriversSection> createState() => _DriversSectionState();
}

/// {state} class.
///
/// Handles [State] for [_DriversSection].
final class _DriversSectionState extends State<_DriversSection> {
  /// {state} whether the section is handling a [DriverExternal] creation.
  DriverCommon? externalDriver;

  /// Initializes the necessary data and entities to handle [DriverExternal] creation.
  void initExternalDriverEntity() {
    externalDriver = DriverCommon();
    externalDriver!.external = DriverExternal();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: '*Driver',
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
            /// --> Driver selection.
            EntityFinderSelector<DriverCommon, DriversServiceI>(
              entityBuilder: () => DriverCommon(),
              label: 'Select a Driver...',
              enabled: externalDriver == null,
              textBuilder: (DriverCommon driver) {
                return "${driver.name} - ${driver.license}";
              },
              onSelected:(DriverCommon? driver) {
                widget.onSelection(driver ?? DriverCommon());
              },  
            ),

            /// --> External Driver Creation.
            FoldPanelWidget(
              title: 'Create External Driver',
              visible: externalDriver != null,
              onChange: (bool visible) {
                setState(() {
                  if (visible) {
                    initExternalDriverEntity();
                  } else {
                    externalDriver = null;
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
                            if (externalDriver == null) return;

                            externalDriver!.license = text;
                            widget.onSelection(externalDriver!);
                          },
                        ),
                      ),

                      /// --> Name & LastName
                      _SpacedWrap(
                        children: <Widget>[
                          /// --> Name
                          TextInput(
                            label: '*Name',
                            width: inputWidth,
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalDriver == null) return;

                              externalDriver!.external!.identification.name = text;
                              widget.onSelection(externalDriver!);
                            },
                          ),

                          /// --> Last Name
                          TextInput(
                            width: inputWidth,
                            label: '*First Last Name',
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalDriver == null) return;

                              externalDriver!.external!.identification.firstLastName = text;
                              widget.onSelection(externalDriver!);
                            },
                          ),
                          TextInput(
                            width: inputWidth,
                            label: 'Second Last Name',
                            maxLength: _kNamingMaxLength,
                            deBounce: _kDefaultInputDebounce,
                            onChanged: (String text) {
                              if (externalDriver == null) return;

                              externalDriver!.external!.identification.secondLastName = text;
                              widget.onSelection(externalDriver!);
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
