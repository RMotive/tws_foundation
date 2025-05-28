import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/tws_view_consume_adapter.dart';
import 'package:tws_foundation_view/src/core/models/tws_state_holder.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/tws_display_flat.dart';
import 'package:tws_foundation_view/src/widgets/tws_list_tile.dart';
import 'package:tws_foundation_view/src/widgets/tws_section.dart';
import 'package:tws_foundation_view/src/widgets/twsf_loading_circule.dart';

/// Header state class.
final class _HeaderState extends ReactorB {}

/// [TwsSelectableList] Display a list of selectable items getted from a [TWSViewConsumeAdapter] class.
class TwsSelectableList<T> extends StatefulWidget {
  /// Section title.
  final String title;

  /// Method to get the title from the [T] type object.
  final String Function(T set) tileTitle;

  /// List heigth.
  final double? heigth;

  /// Items padding
  final EdgeInsetsGeometry padding;

  /// Item background color.
  final Color? backgroundColor;

  /// Item text color.
  final Color? textColor;

  /// Title text alignment.
  final TextAlign titleAlignment;

  /// Subtitle text alignment.
  final TextAlign subtitleAlignment;

  /// Text to show when list content is empty.
  final String emptyContentMessage;

  /// Async data consume adapter.
  final TWSViewConsumeAdapter adapter;

  /// Preselected list values. This list is compared with consume list result and the coincidenses are marked has selected.
  final List<T>? initialValues;

  /// Trigger method on tile selection.
  final Function(bool selected, T item) onSelect;

  /// Custom header implementation.
  final Widget? customHeader;

  /// Custom comparation for [T] objects in [T] lists. If this field is empty, then the .compare list method will be used.
  final bool Function(T item1, T item2)? isEqual;

  /// Interaction status flag.
  final bool enabled;

  const TwsSelectableList({
    super.key,
    required this.title,
    required this.tileTitle,
    required this.adapter,
    required this.onSelect,
    this.heigth,
    this.customHeader,
    this.emptyContentMessage = "Empty content",
    this.padding = const EdgeInsets.all(5),
    this.textColor,
    this.backgroundColor,
    this.titleAlignment = TextAlign.left,
    this.subtitleAlignment = TextAlign.right,
    this.initialValues,
    this.isEqual,
    this.enabled = true,
  });

  @override
  State<TwsSelectableList<T>> createState() => _TwsSelectableListState<T>();
}

class _TwsSelectableListState<T> extends State<TwsSelectableList<T>> {
  /// Theme Manager injector.
  final ThemeManagerI<FoundationThemeB> themeManager =
      Injector.getThemeManager();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late SimpleTheming primaryColorTheme;
  late SimpleTheming pageColorTheme;

  /// Text color.
  late Color tcolor;

  /// Background color.
  late Color bcolor;

  /// Selected items list.
  late List<T> selectedItems;

  /// Data result in [AsyncWidget].
  late List<T> fetchedList;

  /// Declaration for header state.
  late _HeaderState headerState;

  /// Header state effect holder for use outside the [CSMDynamicWidget].
  late void Function() headerEffect;

  /// Waiting widget state.
  late TWSFStateHolder waitingState;
  late void Function() waitingEffect;

  /// Waiting status.
  late bool waiting;

  // Theme method handler.
  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      primaryColorTheme = theme.primaryControlColor;
      pageColorTheme = theme.page;
    });
  }

  @override
  void dispose() {
    themeManager.removeEffect(ref);
    super.dispose();
  }

  @override
  void initState() {
    waitingState = TWSFStateHolder();
    waiting = false;
    selectedItems = widget.initialValues ?? <T>[];
    headerState = _HeaderState();
    headerEffect = () {};
    waitingEffect = () {};
    themeManager.addEffect(ref, themeUpdateListener);
    primaryColorTheme = themeManager.get().primaryControlColor;
    pageColorTheme = themeManager.get().page;
    tcolor = widget.textColor ?? pageColorTheme.fore;
    bcolor = widget.backgroundColor ?? pageColorTheme.back;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TwsSelectableList<T> oldWidget) {
    if (selectedItems != widget.initialValues && widget.enabled) {
      selectedItems = widget.initialValues ?? selectedItems;
    } else if (!widget.enabled) {
      selectedItems = <T>[];
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    tcolor =
        widget.enabled
            ? widget.textColor ?? pageColorTheme.fore
            : widget.textColor?.withValues(alpha: 50) ??
                pageColorTheme.fore.withAlpha(50);
    return TWSSection(
      title: widget.title,
      content: AsyncWidget<List<ViewOutput<dynamic>>>(
        future: () => widget.adapter.consume(1, 9999, ""),
        loadingBuilder: (BuildContext ctx) {
          return Center(
            child: CircularProgressIndicator(color: pageColorTheme.fore),
          );
        },
        errorBuilder: (_, Object? error, _) {
          return const TWSDisplayFlat(display: "Something go wrong");
        },
        successBuilder: (BuildContext ctx, List<ViewOutput<dynamic>> data) {
          fetchedList = data.first.entities as List<T>;
          return Stack(
            children: <Widget>[
              Column(
                spacing: 5,
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
                                "${widget.title}: ${fetchedList.length.toString()}",
                                style: TextStyle(color: tcolor),
                              ),
                            ],
                          );
                        },
                      ),
                  const Divider(),
                  fetchedList.isNotEmpty
                      ? SizedBox(
                        height: widget.heigth,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List<Widget>.generate(
                              fetchedList.length,
                              (int index) {
                                T item = fetchedList[index];
                                String title = widget.tileTitle(item);
                                return TwsListTile(
                                  enabled: widget.enabled,
                                  width: double.maxFinite,
                                  label: title,
                                  textColor: tcolor,
                                  onHoverColor: pageColorTheme.accent,
                                  onHoverTextColor:
                                      pageColorTheme.accentAlt ??
                                      pageColorTheme.fore,
                                  onTap: (bool selected) async {
                                    waiting = true;
                                    waitingEffect();

                                    if (selected) {
                                      selectedItems.add(item);
                                    } else {
                                      selectedItems.remove(item);
                                    }
                                    await widget.onSelect(selected, item);
                                    waiting = false;
                                    waitingEffect();
                                    headerEffect();
                                  },
                                  evaluateSelection: () {
                                    if (widget.isEqual != null) {
                                      bool founded = false;
                                      for (T selectedItem in selectedItems) {
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
                      : TWSDisplayFlat(display: widget.emptyContentMessage),
                ],
              ),
              ReactiveWidget<TWSFStateHolder>(
                reactor: waitingState,
                builder: (BuildContext ctx, TWSFStateHolder state) {
                  waitingEffect = state.react;
                  return Positioned.fill(
                    child: Visibility(
                      visible: waiting,
                      child: AbsorbPointer(
                        child: ColoredBox(
                          color: pageColorTheme.fore.withValues(alpha: 950),
                          child: TwsfLoadingCircle(
                            fit: BoxFit.scaleDown,
                            foreColor: pageColorTheme.back,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
