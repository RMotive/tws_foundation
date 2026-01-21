import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';


/// State class manager for richtext behavior
final class _RichState extends ReactorB { }


/// {widget} class.
///
/// Draws a complex [Widget] that allows to find [EntityI] items and select them.
final class EntityRichFinderSelector<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
   /// [TEntity] builder for conversion.
  final EntityBuilder<TEntity> entityBuilder;

  /// Input label decorator.
  final String? label;

  /// Whether the component is enabled.
  final bool enabled;

  /// Build a custom label text for the [TEntity] items list.
  final String Function(TEntity) textBuilder;

    /// Build a stylished label for [TEntity] selection.
  final InlineSpan Function(TEntity) richTextBuilder;

  /// Pre-selected value for the widget.
  final TEntity? initialValue;

  /// Callback called when an [TEntity] item is selected.
  final void Function(TEntity?)? onSelected;

  /// Optional list of attributes paths to filter the selectable entities, based on the user input text.
  /// 
  /// If this property is null, no filtering will be applied and the search function will not be excecuted.
  /// 
  /// The exact property path must be provided as defined in the [TEntity] model.
  /// 
  /// Example for [Yardlog] as [TEntity]: '${YardLog.kSection}.${EntityKeys.name}', 
  /// this means that the section name property will be used to filter the selectable entities.
  ///
  /// To add more more filters, just add more paths to the list.
  /// 
  /// The default filter behavior is OR and CONTAINS, so if any of the properties contains the input text, the entity will be included in the results.
  final List<String>? filterBy;

  /// Creates a new [EntityRichFinderSelector] instance.
  const EntityRichFinderSelector({
    super.key,
    this.label,
    this.enabled = true,
    this.initialValue,
    this.onSelected,
    this.filterBy,
    required this.richTextBuilder,
    required this.entityBuilder,
    required this.textBuilder,
  });

  @override
  State<EntityRichFinderSelector<TEntity, TService>> createState() => _EntityFinderSelectorState<TEntity, TService>();
}

/// {state} class.
///
/// Handles [State] for [EntityRichFinderSelector].
final class _EntityFinderSelectorState<TEntity extends EntityI<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<EntityRichFinderSelector<TEntity, TService>> {

  /// {state} current application theme data.
  late FoundationThemeB theme = Theming.get(context);

  /// Rich text state overlay.
  late _RichState richState;

  /// Current overlay visibility status.
  bool overlayIsShowing = false;

  /// Current selected entity.
  TEntity? selected;

  void Function() richReact = () {};

  @override
  void initState() {
    super.initState();
    richState = _RichState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theming.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        EntityFinderSelector<TEntity, TService>(
          label: widget.label,
          enabled: widget.enabled,
          entityBuilder: widget.entityBuilder,
          textBuilder: widget.textBuilder,
          initialValue: widget.initialValue,
          filterBy: widget.filterBy,
          overlayStatus:(bool isVisible) {
            overlayIsShowing = isVisible;
            richReact();
          },
          onSelected: (TEntity? selected) {
            widget.onSelected?.call(selected);
            this.selected = selected;
            richReact();
          },
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: ReactiveWidget<_RichState>(
              reactor: richState,
              builder: (BuildContext ctx, _RichState reactor) {
                richReact = reactor.react;     
                return Visibility(
                  visible: !overlayIsShowing && selected != null,
                  replacement: Container(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.page.back, 
                      ),
                      child: RichText(
                        text:
                            selected != null
                                ? widget.richTextBuilder(selected!)
                                : const TextSpan(text: ''),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
