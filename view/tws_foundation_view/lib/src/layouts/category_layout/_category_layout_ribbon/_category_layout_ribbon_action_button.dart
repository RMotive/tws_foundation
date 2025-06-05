part of '../category_layout.dart';

/// {widget} class.
///
/// Draws and manages an [CategoryLayout] action ribbon button.
final class _CategoryLayoutRibbonActionButton extends StatefulWidget {
  /// Action button options.
  final CategoryLayoutRibbonActionOptionsI options;

  /// Creates a new [_CategoryLayoutRibbonActionButton] instance.
  const _CategoryLayoutRibbonActionButton({
    required this.options,
  });

  @override
  State<_CategoryLayoutRibbonActionButton> createState() => _CategoryLayoutRibbonActionButtonState();
}

/// {state} class.
///
/// Implements [State] handling for [_CategoryLayoutRibbonArticleButton].
final class _CategoryLayoutRibbonActionButtonState extends State<_CategoryLayoutRibbonActionButton> {
  /// {ref} Theme effect reference.
  final UniqueKey themingRef = UniqueKey();

  /// [Widget] scoped theme properties.
  late StateTheming stateTheming;

  /// [Widget] current state.
  late CSMStates state;

  /// Whether the current [Widget] is waiting to finish invokation.
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

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

  /// {event} Triggered when the user mouse pointer clicks on the button.
  void onClick() async {
    setState(() {
      isLoading = true;
    });

    await widget.options.onInvoke();

    setState(() {
      isLoading = false;
    });
  }

  /// {event} Triggered when the user mouse pointer is in / out button pointer area.
  void onHover(bool $in) {
    setState(() {
      state = $in ? CSMStates.hovered : CSMStates.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ComplexTheming theming = state.evaluateTheme(stateTheming);

    return Tooltip(
      message: widget.options.description,
      child: PointerArea(
        onClick: isLoading ? null : onClick,
        onHover: isLoading ? null : onHover,
        child: AspectRatio(
          aspectRatio: 1,
          child: ColoredBox(
            color: theming.background!,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Visibility(
                child: Column(
                  spacing: 1,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.options.iconBuilder(theming.foreground!),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        widget.options.title,
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
                replacement: CircularProgressIndicator(
                  color: theming.foreground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
