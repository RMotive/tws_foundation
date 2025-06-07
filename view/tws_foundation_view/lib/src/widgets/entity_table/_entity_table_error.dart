part of 'entity_table.dart';

/// {private} {widget} class.
///
/// Draws an error display message when an error has being caugth during [EntityTable] phase.
final class _EntityTableError extends StatelessWidget {
  /// Display error width.
  static const double _displayWidth = 300;

  /// Creates a new [_EntityTableError] instance.
  const _EntityTableError();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        final Size boxingSize = constrains.biggest;
        final SimpleTheming errorTheming = Theming.get<FoundationThemeB>().primaryCriticalControl;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (boxingSize.width / 2) - (_displayWidth / 2),
          ),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                size: 48,
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: errorTheming.fore,
              ),
              TWSDisplayFlat(
                width: _displayWidth,
                display: 'Connection error',
                color: errorTheming.fore,
                foreColor: errorTheming.accent,
              ),
            ],
          ),
        );
      },
    );
  }
}
