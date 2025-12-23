part of 'entity_table.dart';

class _EntityTableFilter<TEntity extends EntityB<TEntity>> extends StatefulWidget {
  /// Draws a section containing filtering widgets.
  /// 
  /// [set] Current filtering set. This value is used to store the filtering data.
  /// The widgets returned from this method must update the [set] propeties in order to apply the 
  /// filtering when the search action button is pressed.
  final Widget Function(TEntity set) filtersSection;

  /// Object initialization factory, since Front-End frameworks don't use to have {reflections} to auto detect parameterless constructors.
  final TEntity Function() entityFactory;

  /// Callback executed when the search action button is pressed.
  final void Function(TEntity set) onSearch;

  /// Callback executed when the clean action button is pressed.
  final void Function(TEntity set) onClean;

  const _EntityTableFilter({
    required this.filtersSection,
    required this.entityFactory,
    required this.onSearch,
    required this.onClean
  });

  @override
  State<_EntityTableFilter<TEntity>> createState() => __EntityTableFilterState<TEntity>();
}

class __EntityTableFilterState<TEntity extends EntityB<TEntity>> extends State<_EntityTableFilter<TEntity>> {

  /// filtering set.
  late TEntity set;

  @override
  void initState() {
    set = widget.entityFactory();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: <Widget>[
        /// --> Filtering widgets section
        widget.filtersSection(set),

        /// --> Footer action buttons
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonFlat(
              label: 'Clear',
              onClick: () {
                set = widget.entityFactory();
                widget.onClean(set);
                // setState(() {
                //   set = widget.entityFactory();
                // });
              },
            ),
            ButtonFlat(
              label: 'Search',
              onClick: () => widget.onSearch(set),
            ),
          ],
        )
        
      ],
    );
  }
}