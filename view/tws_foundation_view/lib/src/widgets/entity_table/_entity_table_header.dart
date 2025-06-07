part of 'entity_table.dart';

///
final class _EntityTableHeader<TEntity> extends StatelessWidget {
  ///
  final List<EntityTableColumnOptions<TEntity>> columns;

  ///
  const _EntityTableHeader({
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<FoundationThemeB> themeManager = Injector.get();

    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        final Size boxSize = boxConstraints.biggest;
        final double colWidth = boxSize.width / columns.length;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 1, color: Colors.blueGrey),
            ),
          ),
          child: Row(
            children: <Widget>[
              for (int cont = 0; cont < columns.length; cont++)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: columns[cont].width ?? _kColumnWidth,
                  ),
                  child: SizedBox(
                    width: columns[cont].width ?? colWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      child: Text(
                        columns[cont].title,
                        style: TextStyle(
                          color: themeManager.get().page.fore,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
