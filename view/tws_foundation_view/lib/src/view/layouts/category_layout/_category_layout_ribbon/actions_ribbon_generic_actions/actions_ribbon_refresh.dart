import 'dart:async';
import 'package:tws_foundation_view/tws_foundation_view.dart';

///
final class ActionsRisbbonRefresh extends ActionsRibbonActionB {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function() onPerform;

  /// Creates a new [ActionsRisbbonRefresh] instance.
  const ActionsRisbbonRefresh({
    required this.onPerform,
  }) : super(
         title: 'Refresh',
       );
  @override
  FutureOr<void> perform() => onPerform;
}
