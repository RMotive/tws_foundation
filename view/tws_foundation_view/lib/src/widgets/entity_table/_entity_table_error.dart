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

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (boxingSize.width / 2) - (_displayWidth / 2),
          ),
          child: const TWSDisplayFlat(
            width: _displayWidth,
            display: 'Critical error reading {view} engine',
          ),
        );
      },
    );
  }
}
