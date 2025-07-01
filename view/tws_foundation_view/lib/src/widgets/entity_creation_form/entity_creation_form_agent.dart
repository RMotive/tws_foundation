import 'package:flutter/foundation.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// [class] implementation.
///
/// Implements a proxy controller to handle and interact with a [EntityCreationForm] outside the scope.
final class EntityCreationFormController extends ChangeNotifier {
  /// Creates a new [EntityCreationFormController] instance.
  EntityCreationFormController();

  /// Triggers a [create] invokation at the [EntityCreationForm].
  void create() {
    notifyListeners();
  }
}
