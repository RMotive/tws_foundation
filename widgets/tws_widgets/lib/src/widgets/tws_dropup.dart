import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_widgets/src/core/constants/foundation_colors.dart';
import 'package:tws_widgets/tws_widgets.dart';
/// [TWSDropup] Displays a interactable control. When this control is tapped, deploy an aditional section in a drop up animation.
/// The content in this section is an interactable list of [T] items.
class TWSDropup<T> extends StatefulWidget {
  /// Initial selection item.
  final T item;

  /// Options list to display.
  final List<T> items;

  /// Message to show on hover.
  final String? tooltip;

  /// Trigger method on select an item.
  final void Function(T item) onChange;

  /// Flag to enabled or disabled widget.
  final bool disabled;

  const TWSDropup({
    super.key,
    this.tooltip,
    this.disabled = false,
    required this.item,
    required this.items,
    required this.onChange,
  });

  @override
  State<TWSDropup<T>> createState() => _TWSDropupState<T>();
}

class _TWSDropupState<T> extends State<TWSDropup<T>> with TickerProviderStateMixin {
  /// Cascade options link.
  final LayerLink layerLink = LayerLink();
  /// initialize State.
  CSMStates state = CSMStates.none;
  /// Theme color scheme.
  // The theme behaviors may change in some statefull widgets. The [CSMGenericThemeOptions] and [CSMStateThemeOptions] approach is 
  // compatible with [TickerProviderStateMixin] and more complex states implementations.
  late CSMGenericThemeOptions theme;
  late CSMStateThemeOptions themeState;

  /// Options cascade overlay entry.
  late OverlayEntry? overlay;
  /// Currently selected item.
  late T currentItem;
  // --> Animations
  late AnimationController animController;
  late Animation<double> expandAnimation;
  late Animation<double> rotateAnimation;

  OverlayEntry composeOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double topOffset = offset.dy + size.height;

    return OverlayEntry(
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            toogleDrawer(true).then(
              (_) => updateState(CSMStates.none),
            );
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: offset.dx,
                bottom: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  link: layerLink,
                  followerAnchor: Alignment.bottomLeft,
                  offset: const Offset(0, 0),
                  showWhenUnlinked: false,
                  child: SizeTransition(
                    sizeFactor: expandAnimation,
                    child: ColoredBox(
                      color: theme.background ?? TWSFColors.ligthGrey,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 250,
                        ),
                        child: SizedBox(
                          height: 16 + ((widget.items.length - 1) * 32),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: ListView.builder(
                              itemCount: widget.items.length,
                              itemBuilder: (_, int index) {
                                bool current = widget.items[index] == currentItem;

                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      toogleDrawer(true).then(
                                        (_) => updateState(CSMStates.none, currentItem: widget.items[index]),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 32,
                                      width: size.width,
                                      child: Center(
                                        child: Text(
                                          '${widget.items[index]}',
                                          style: TextStyle(
                                            color: current ? theme.foreground : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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

  Future<void> toogleDrawer([bool close = false]) async {
    if (close) {
      await animController.reverse();
      overlay?.remove();
      overlay = null;
    } else {
      overlay = composeOverlay();
      Overlay.of(context).insert(overlay!);
      animController.forward();
    }
  }
  void themeUpdate({TWSFThemeBase? theming}) {
    setState(() {
      theming ??= getTheme();
      themeState = theming!.primaryControlState;
      theme = state.evaluateTheme(themeState);
    });
  }

  void updateState(CSMStates state, {T? currentItem}) {
    setState(() {
      this.state = state;
      this.currentItem = currentItem ?? this.currentItem;
      theme = state.evaluateTheme(themeState);
    });
    if (currentItem != null) {
      widget.onChange(currentItem);
    }
  }

  @override
  void didUpdateWidget(covariant TWSDropup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.disabled && widget.disabled != oldWidget.disabled) {
      updateState(CSMStates.hovered);
    }
  }

  @override
  void initState() {
    assert(widget.items.isNotEmpty, 'The items list must have at least one item');
    super.initState();
    currentItem = widget.item;
    animController = AnimationController(
      vsync: this,
      duration: 300.miliseconds,
    );
    expandAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    );
    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: .5,
    ).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeInOut),
    );

    TWSFThemeBase theming = getTheme(
      updateEfect: themeUpdate,
    );
    themeUpdate(theming: theming);
    if (widget.disabled) {
      updateState(CSMStates.hovered);
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeEffect(themeUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      child: CompositedTransformTarget(
        link: layerLink,
        child: CSMPointerHandler(
          onClick: () {
            if (widget.disabled) return;
            if (state == CSMStates.selected) {
              updateState(CSMStates.hovered);
              toogleDrawer(true);
            } else {
              updateState(CSMStates.selected);
              toogleDrawer();
            }
          },
          cursor: SystemMouseCursors.click,
          onHover: (bool $in) {
            if (widget.disabled) return;
            if (state == CSMStates.selected) return;
            updateState($in ? CSMStates.hovered : CSMStates.none);
          },
          child: ColoredBox(
            color: theme.background ?? TWSFColors.ligthGrey,
            child: SizedBox(
              width: 75,
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '$currentItem',
                    style: TextStyle(
                      color: theme.foreground,
                    ),
                  ),
                  RotationTransition(
                    turns: rotateAnimation,
                    child: Icon(
                      Icons.arrow_drop_up_rounded,
                      color: theme.foreground,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
