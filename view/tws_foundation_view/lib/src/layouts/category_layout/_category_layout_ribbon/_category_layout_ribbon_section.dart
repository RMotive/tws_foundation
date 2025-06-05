part of '../category_layout.dart';

///
final class _CategoryLayoutRibbonSection extends StatelessWidget {
  /// Section children [Widget] collection at the inner [Row], it is [ScrollView].
  final List<Widget> children;

  /// Creates a new [_CategoryLayoutRibbonSection] instance.
  const _CategoryLayoutRibbonSection({
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size sectionSize = constraints.biggest;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                width: 1,
                color: Colors.blueGrey,
              ),
            ),
          ),
          child: SizedBox.fromSize(
            size: sectionSize,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  spacing: 4,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
