import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Dialog, Router;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class. Builds a widget dialog to show to the user a list of invalidations.
class InvalidatingDialog extends StatelessWidget {
  /// Dialog title.
  final String title;

  /// Invalidation list.
  final List<EntityInvalidation<Object>> invalidations;

  /// Routing funtionality handler.
  final Router router;
  
  /// Current context to show the dialog.
  final BuildContext context;

  const InvalidatingDialog({
    super.key,
    required this.title,
    required this.invalidations,
    required this.router,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      showCancelButton: false,
      title: title,
      content: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text:'Invalid values founded, Verify the following values and try again:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            
          ),
          children: List<TextSpan>.generate(
            invalidations.length, 
            (int index) => TextSpan(
              text: '\n\u2022 ${invalidations[index].property.name}: ${invalidations[index].reason}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        )
      ),
      theming: Theming.get<FoundationThemeB>(context).error,
      onAccept: () {
        router.pop();
      },
    );
  }
}