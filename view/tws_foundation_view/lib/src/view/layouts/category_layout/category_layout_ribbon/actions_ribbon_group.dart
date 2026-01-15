import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Represents a group of action buttons to be composed along [CategoryLayoutPageI] actions ribbon.
final class ActionsRibbonGroup implements ActionsRibbonNodeI {
  /// Group title.
  final String title;

  /// Group actions.
  final List<ActionsRibbonActionI> actions;

  /// Creates a new [ActionsRibbonGroup] instance.
  const ActionsRibbonGroup({
    required this.title,
    required this.actions,
  });

  @override
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size sectionSize = constraints.biggest;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                width: 1,
                color: Colors.blueGrey,
              ),
            ),
          ),
          child: SizedBox.fromSize(
            size: sectionSize,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  spacing: 4,
                  children: <Widget>[
                    for (ActionsRibbonActionI action in actions) action.compose(messengerRef),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
