import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/view/widgets/list_tile.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Header state class.
final class _HeaderState extends ReactorBase {}

/// [SelectableList] Display a list of selectable items getted from a generic class.
class SelectableList<TEntity extends IEntity<TEntity>> extends StatefulWidget {

  /// Interaction status flag.
  final bool enabled;

  /// Section title.
  final String title;

  /// Method to get the title from the [T] type object.
  final String Function(TEntity set) tileTitle;

  /// List content to display.
  final List<TEntity> content;

  /// Max fetched items. Default is 9999 items.
  final int maxItems;

  /// Items padding
  final EdgeInsetsGeometry padding;

  /// Title text alignment.
  final TextAlign titleAlignment;

  /// Subtitle text alignment.
  final TextAlign subtitleAlignment;

  /// Text to show when list content is empty.
  final String emptyContentMessage;

  /// Trigger method on tile selection.
  final Function(bool selected, TEntity item) onSelect;

  /// Custom comparation for [T] objects in [T] lists. If this field is empty, then the .compare list method will be used.
  final bool Function(TEntity item1, TEntity item2)? isEqual;

  /// List height.
  final double? height;

  /// Item background color.
  final Color? backgroundColor;

  /// Item text color.
  final Color? textColor;

  /// Preselected list values. This list is compared with consume list result and the coincidenses are marked has selected.
  final List<TEntity>? selectedValues;

  /// Custom header implementation.
  final Widget? customHeader;

  const SelectableList({
    super.key,
    required this.title,
    required this.tileTitle,
    required this.onSelect,
    required this.content,
    this.height,
    this.customHeader,
    this.emptyContentMessage = "Empty content",
    this.padding = const EdgeInsets.all(5),
    this.textColor,
    this.backgroundColor,
    this.titleAlignment = TextAlign.left,
    this.subtitleAlignment = TextAlign.right,
    this.selectedValues,
    this.isEqual,
    this.enabled = true,
    this.maxItems = 9999,
  });

  @override
  State<SelectableList<TEntity>> createState() => _SelectableListState<TEntity>();
}

final class _SelectableListState<TEntity extends IEntity<TEntity>> extends State<SelectableList<TEntity>> {
  
  /// Theme Manager InjectorUtils.
  late FoundationThemeB themeManager = ThemingUtils.get(context);

  /// Color pallet for the component.
  late ThemingData primaryColorTheme;
  late ThemingData pageColorTheme;

  /// Text color.
  late Color tcolor;

  /// Background color.
  late Color bcolor;

  /// Selected items list.
  late List<TEntity> selectedItems;

  /// Declaration for header state.
  late _HeaderState headerState;

  /// Header state effect holder for use outside the [ReactiveWidget].
  late void Function() headerEffect;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeManager = ThemingUtils.get(context);
    primaryColorTheme = themeManager.control;
    pageColorTheme = themeManager.page;
    tcolor = widget.textColor ?? pageColorTheme.fore;
    bcolor = widget.backgroundColor ?? pageColorTheme.back;  
  }

  @override
  void initState() {
    selectedItems = widget.selectedValues ?? <TEntity>[];
    headerState = _HeaderState();
    headerEffect = () {};
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectableList<TEntity> oldWidget) {
    if (selectedItems != widget.selectedValues && widget.enabled) {
      selectedItems = widget.selectedValues ?? selectedItems;
    } else if (!widget.enabled) {
      selectedItems = <TEntity>[];
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    tcolor =
        widget.enabled
            ? widget.textColor ?? pageColorTheme.fore
            : widget.textColor?.withValues(alpha: 50) ?? pageColorTheme.fore.withAlpha(50);
    return SectionWidget(
      title: widget.title,
      child: Column(
        children: <Widget>[
          widget.customHeader != null
              ? widget.customHeader!
              : ReactiveWidget<_HeaderState>(
                reactor: headerState,
                builder: (BuildContext ctx, _HeaderState state) {
                  headerEffect = state.react;
                  return Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Selected: ${selectedItems.length}",
                        style: TextStyle(color: tcolor),
                      ),
                      Text(
                        "${widget.title}: ${widget.content.length.toString()}",
                        style: TextStyle(color: tcolor),
                      ),
                    ],
                  );
                },
              ),
          const Divider(),
          widget.content.isNotEmpty
              ? SizedBox(
                height: widget.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: List<Widget>.generate(
                      widget.content.length,
                      (int index) {
                        TEntity item = widget.content[index];
                        String title = widget.tileTitle(item);
                        return CollectionTile(
                          enabled: widget.enabled,
                          width: double.maxFinite,
                          label: title,
                          textColor: tcolor,
                          onHoverColor: pageColorTheme.accent,
                          onHoverTextColor: pageColorTheme.accentAlt ?? pageColorTheme.fore,
                          onTap: (bool selected) async {
                            if (selected) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                            await widget.onSelect(selected, item);
                            headerEffect();
                          },
                          evaluateSelection: () {
                            if (widget.isEqual != null) {
                              bool founded = false;
                              for (TEntity selectedItem in selectedItems) {
                                if (widget.isEqual!(
                                  selectedItem,
                                  item,
                                )) {
                                  founded = true;
                                  break;
                                }
                              }
                              return founded;
                            }
                            return selectedItems.contains(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
              : MessageWidget(text: widget.emptyContentMessage),
        ],
      ),
    );
  }
}
