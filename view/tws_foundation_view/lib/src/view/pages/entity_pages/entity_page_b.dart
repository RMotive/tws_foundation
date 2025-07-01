import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
///
abstract class EntityPageB<TAdapter extends EntityTableAdapterI> extends PageB {
  /// Adapter handler.
  final TAdapter adapter;

  /// Creates a new [EntityPageB] instance.
  const EntityPageB({
    required this.adapter,
  });
}
