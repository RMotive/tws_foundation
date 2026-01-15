import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/view/layouts/category_layout/category_layout.dart';

/// Represents a [CategoryLayourRibbon]
abstract interface class ActionsRibbonNodeI {
  /// Composes the [ActionsRibbonNodeI] representation as a [Widget].
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef);
}
