import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Dialog, Router;
import 'package:tws_foundation_view/src/core/models/text_label.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class. Builds a widget dialog to show to the user a list text labels resume.
class ResumeDialog extends StatelessWidget {
  /// Dialog title.
  final String title;

  /// Dialog sub title.
  final String subTitle;

  /// Dialog confirmation action message.
  final String acceptLabel;

  /// Invalidation list.
  final List<TextLabel> values;

  /// Routing funtionality handler.
  final Router router;
  
  /// Current context to show the dialog.
  final BuildContext context;

  /// Trigger on accept dialog.
  final FutureOr<void> Function()? onAccept;

  const ResumeDialog({
    super.key,
    required this.title,
    required this.router,
    required this.context,
    required this.values,
    this.subTitle = 'Are you sure you want to update the following values?',
    this.acceptLabel = 'Accept',
    this.onAccept,
  });

  List<InlineSpan> _buildSpans() {
    List<InlineSpan> spans = <InlineSpan>[];
    for (final TextLabel label in values) {
      spans.add(
        TextSpan(
          text: '\n\u2022 ${label.title}:',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      );
      spans.add(
        WidgetSpan(
          baseline: TextBaseline.alphabetic,
          alignment: PlaceholderAlignment.bottom,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text('\n${label.value}'),
          ),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final List<InlineSpan> values = _buildSpans();
    return Dialog(
      showCancelButton: false,
      title: title,
      acceptLabel: acceptLabel,
      content: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: subTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: List<InlineSpan>.generate(
            values.length, 
            (int index) => values[index],
          )
        )
      ),
      theming: Theming.get<FoundationThemeB>(context).error,
      onAccept: () async {
        await onAccept?.call();
        router.pop();
      },
    );
  }
}