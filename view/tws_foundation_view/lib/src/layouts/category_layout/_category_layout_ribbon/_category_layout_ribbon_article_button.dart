part of '../category_layout.dart';

/// {widget} class.
///
/// Draws and manages the articles layout selector ribbon buttons states and behavior.
class _CategoryLayoutRibbonArticleButton extends StatefulWidget {
  /// Whether this button is the current routed one.
  final bool isCurrent;

  /// Article entry options.
  final CategoryLayoutEntryI articleEntry;

  const _CategoryLayoutRibbonArticleButton({
    required this.isCurrent,
    required this.articleEntry,
  });

  @override
  State<_CategoryLayoutRibbonArticleButton> createState() => _CategoryLayoutRibbonArticleButtonState();
}

/// {state} class.
///
/// Implements [State] handling for [_CategoryLayoutRibbonArticleButton].
final class _CategoryLayoutRibbonArticleButtonState extends State<_CategoryLayoutRibbonArticleButton> {
  /// {ref} Theme effect reference.
  final UniqueKey themingRef = UniqueKey();

  /// [Widget] scoped theme properties.
  late StateTheming stateTheming;

  /// [Widget] current state.
  late CSMStates state;

  @override
  void initState() {
    super.initState();

    state = widget.isCurrent ? CSMStates.selected : CSMStates.none;
    stateTheming = Theming.get<FoundationThemeB>().categoryLayoutRibbonButton;
    Injector.getThemeManager<FoundationThemeB>().addEffect(
      themingRef,
      (FoundationThemeB theme) {
        setState(() {
          stateTheming = theme.categoryLayoutRibbonButton;
        });
      },
    );
  }

  @override
  void dispose() {
    Injector.getThemeManager().removeEffect(themingRef);
    super.dispose();
  }

  /// {event} Triggered when button is clicked.
  void onClick() {
    Injector.get<Router>().go(widget.articleEntry.route);
  }

  /// {event} Triggered when the user mouse pointer is in / out button pointer area.
  void onHover(bool $in) {
    if (widget.isCurrent) return;

    setState(() {
      state = $in ? CSMStates.hovered : CSMStates.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ComplexTheming theming = state.evaluateTheme(stateTheming);
    final CategoryLayoutEntryI articleEntry = widget.articleEntry;

    return PointerArea(
      cursor: !widget.isCurrent ? SystemMouseCursors.click : MouseCursor.defer,
      onClick: widget.isCurrent ? null : onClick,
      onHover: onHover,
      child: AspectRatio(
        aspectRatio: 1,
        child: ColoredBox(
          color: theming.background!,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              spacing: 1,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                articleEntry.iconBuilder(theming.foreground),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    articleEntry.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: theming.foreground,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
