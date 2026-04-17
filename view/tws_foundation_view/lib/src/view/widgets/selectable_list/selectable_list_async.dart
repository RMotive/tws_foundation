import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/view_consume_adapter.dart';
import 'package:tws_foundation_view/src/core/models/tws_state_holder.dart';
import 'package:tws_foundation_view/src/view/widgets/loading_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list/selectable_list.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// [SelectableListAsync] Display a list of selectable items getted from a [ViewConsumeAdapter] class.
class SelectableListAsync<TEntity extends IEntity<TEntity>, TService extends IViewService<TEntity, FoundationResponseResolver<ViewOutput<TEntity>>>> extends StatefulWidget {
  /// [TEntity] builder for conversion.
  final EntityBuilder<TEntity> entityBuilder;
  
  /// Section title.
  final String title;

  /// Method to get the title from the [T] type object.
  final String Function(TEntity set) tileTitle;

  /// List height.
  final double? height;

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

  const SelectableListAsync({
    super.key,
    required this.title,
    required this.tileTitle,
    required this.onSelect,
    required this.entityBuilder,
    this.height,
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
  State<SelectableListAsync<TEntity, TService>> createState() => _SelectableListAsyncState<TEntity, TService>();
}

final class _SelectableListAsyncState<TEntity extends IEntity<TEntity>, TService extends IViewService<TEntity, FoundationResponseResolver<ViewOutput<TEntity>>>> extends State<SelectableListAsync<TEntity, TService>> {
 
  /// {dep} [TEntity] based service dependency.
  final TService service = InjectorUtils.get();
  
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

  /// Data result in [AsyncWidget].
  late List<TEntity> fetchedList;

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
    waitingEffect = () {};
    _viewInvok = viewInvokation();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectableListAsync<TEntity, TService> oldWidget) {
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
              SelectableList<TEntity>(
                title: widget.title,
                tileTitle: widget.tileTitle,
                content: fetchedList,
                maxItems: widget.maxItems,
                enabled: widget.enabled,
                textColor: widget.textColor,
                backgroundColor: widget.backgroundColor,
                titleAlignment: widget.titleAlignment,
                subtitleAlignment: widget.subtitleAlignment,
                emptyContentMessage: widget.emptyContentMessage,
                customHeader: widget.customHeader,
                padding: widget.padding,
                selectedValues: widget.initialValues,
                height: widget.height,
                isEqual: widget.isEqual,
                onSelect: (bool selected, TEntity item) async {
                  waiting = true;
                  waitingEffect();

                  await widget.onSelect(selected, item);
                  
                  waiting = false;
                  waitingEffect();
                },

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
