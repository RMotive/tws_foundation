import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a foldable panel component displaying a selectable text to open the panel and another one to close it.
final class FoldPanelWidget extends StatefulWidget {
  /// Panel title.
  final String title;

  /// Child content panel.
  final Widget child;

  /// Whether the panel is visible.
  final bool visible;

  /// {event} callback called when the panel visibility changes.
  final void Function(bool visible)? onChange;

  /// Creates a new [FoldPanelWidget] instance.
  const FoldPanelWidget({
    super.key,
    this.onChange,
    this.visible = false,
    required this.title,
    required this.child,
  });

  @override
  State<FoldPanelWidget> createState() => _FoldPanelWidgetState();
}

/// {state} class.
///
/// Handles [State] for [FoldPanelWidget].
final class _FoldPanelWidgetState extends State<FoldPanelWidget> {
  /// {state} current application theme data.
  late FoundationThemeB theme = ThemingUtils.get(context);

  /// {state} whether the component is opened.
  late bool shown = widget.visible;

  @override
  void didUpdateWidget(covariant FoldPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.visible != oldWidget.visible) {
      shown = widget.visible;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = ThemingUtils.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// --> Opne / Hide action button.
        TextButton(
          text: shown ? 'Hide ${widget.title}' : 'Show ${widget.title}',
          onTap: () {
            setState(() {
              shown = !shown;
              widget.onChange?.call(shown);
            });
          },
        ),

        if (shown)
          SectionWidget(
            title: widget.title,
            outterPadding: EdgeInsets.only(
              top: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: widget.child,
            ),
          ),
      ],
    );
  }
}
