import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/view_consume_adapter.dart';
import 'package:tws_foundation_view/src/core/models/tws_state_holder.dart';
import 'package:tws_foundation_view/src/view/widgets/list_tile.dart';
import 'package:tws_foundation_view/src/view/widgets/loading_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Header state class.
final class _HeaderState extends ReactorBase {}

/// [SelectableList] Display a list of selectable items getted from a [ViewConsumeAdapter] class.
class SelectableList<TEntity extends IEntity<TEntity>, TService extends IViewService<TEntity, FoundationResponseResolver<ViewOutput<TEntity>>>> extends StatefulWidget {
  /// [TEntity] builder for conversion.
  final EntityBuilder<TEntity> entityBuilder;
  
  /// Section title.
  final String title;

  /// Method to get the title from the [T] type object.
  final String Function(TEntity set) tileTitle;

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

  /// Preselected list values. This list is compared with consume list result and the coincidenses are marked has selected.
  final List<TEntity>? initialValues;

  /// Trigger method on tile selection.
  final Function(bool selected, TEntity item) onSelect;

  /// Custom header implementation.
  final Widget? customHeader;

  /// Custom comparation for [T] objects in [T] lists. If this field is empty, then the .compare list method will be used.
  final bool Function(TEntity item1, TEntity item2)? isEqual;

  /// Interaction status flag.
  final bool enabled;

  /// Max fetched items. Default is 9999 items.
  final int maxItems;

  const SelectableList({
    super.key,
    required this.title,
    required this.tileTitle,
    required this.onSelect,
    required this.entityBuilder,
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
    this.maxItems = 9999,
  });

  @override
  State<SelectableList<TEntity, TService>> createState() => _SelectableListState<TEntity, TService>();
}

final class _SelectableListState<TEntity extends IEntity<TEntity>, TService extends IViewService<TEntity, FoundationResponseResolver<ViewOutput<TEntity>>>> extends State<SelectableList<TEntity, TService>> {
 
  /// {dep} [TEntity] based service dependency.
  final TService service = InjectorUtils.get();
  
  /// Theme Manager InjectorUtils.
  late FoundationThemeB themeManager = ThemingUtils.get(context);

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late ThemingData primaryColorTheme;
  late ThemingData pageColorTheme;

  /// Text color.
  late Color tcolor;

  /// Background color.
  late Color bcolor;

  /// Selected items list.
  late List<TEntity> selectedItems;

  /// Data result in [AsyncWidget].
  late List<TEntity> fetchedList;

  /// Declaration for header state.
  late _HeaderState headerState;

  /// Header state effect holder for use outside the [CSMDynamicWidget].
  late void Function() headerEffect;

  /// Waiting widget state.
  late TWSFStateHolder waitingState;
  late void Function() waitingEffect;

  /// Waiting status.
  late bool waiting;

  /// {state} current service invokation instance.
  late Future<ViewOutput<TEntity>> _viewInvok;

   /// Manage the service view data consume to populate the list content.
  Future<ViewOutput<TEntity>> viewInvokation() async {
    SessionStorageI sessionStorage = InjectorUtils.get();

    FoundationResponseResolver<ViewOutput<TEntity>> resolver = await service.view(
      ViewInput<TEntity>.b(widget.maxItems, 1),
      sessionStorage.token,
    );

    ViewOutput<TEntity> result =  resolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.entityBuilder),
    );

    return result;
  }
  
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
    waitingState = TWSFStateHolder();
    waiting = false;
    selectedItems = widget.initialValues ?? <TEntity>[];
    headerState = _HeaderState();
    headerEffect = () {};
    waitingEffect = () {};
    _viewInvok = viewInvokation();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectableList<TEntity, TService> oldWidget) {
    if (selectedItems != widget.initialValues && widget.enabled) {
      selectedItems = widget.initialValues ?? selectedItems;
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
      child: AsyncWidget<ViewOutput<TEntity>>(
        future: _viewInvok,
        loadingBuilder: (BuildContext ctx) {
          return Center(
            child: CircularProgressIndicator(color: pageColorTheme.fore),
          );
        },
        errorBuilder: (_, Object? error, _) {
          return const MessageWidget(text: "Something go wrong");
        },
        successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
          fetchedList = data.entities;
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
                                TEntity item = fetchedList[index];
                                String title = widget.tileTitle(item);
                                return CollectionTile(
                                  enabled: widget.enabled,
                                  width: double.maxFinite,
                                  label: title,
                                  textColor: tcolor,
                                  onHoverColor: pageColorTheme.accent,
                                  onHoverTextColor: pageColorTheme.accentAlt ?? pageColorTheme.fore,
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
                          child: LoadingWidget(
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
