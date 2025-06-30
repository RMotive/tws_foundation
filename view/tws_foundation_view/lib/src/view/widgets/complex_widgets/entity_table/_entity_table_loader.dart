part of 'entity_table.dart';

/// {private} {widget} class.
///
/// Draws a [ProgressIndicator] for the [EntityTable] when is consuming remote data.
final class _EntityTableLoader extends StatelessWidget {
  /// Inner [ProgressIndicator] height.
  static const double _loaderSize = 50;

  /// Creates a new [_EntityTableLoader] instance.
  const _EntityTableLoader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {

        boxConstraints = boxConstraints.boxed();
        final Size boxingSize = boxConstraints.biggest;

        return SizedBox.fromSize(
          size: boxingSize,
          child: Center(
            child: SizedBox.fromSize(
              size: Size.square(_loaderSize),
              child: CircularProgressIndicator(
                backgroundColor: FoundationColors.oceanBlueH,
                color: FoundationColors.oceanBlue,
                strokeWidth: 3,
              ),
            ),
          ),
        );
      },
    );
  }
}
