
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/yardlogs/create_whisper/create_yardlogs_whisper.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_whisper_content.dart';

/// {constant} default spacing between elements.
const double _kDefSpacing = 10;

/// Simplifies [Wrap] draw giving default spacing values.
final class _SpacedWrap extends StatelessWidget {
  /// Inner [Wrap.children] proxy value.
  final List<Widget> children;

  /// Creates a new [_SpacedWrap] instance.
  const _SpacedWrap({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: _kDefSpacing,
      runSpacing: _kDefSpacing,
      children: children,
    );
  }
}

/// {whisper} class.
final class CreateYardLogsReservationsWhisper extends ViewPageBase {
  /// Inner [YardLogsEntityTableAdapter] instance.
  final YardLogsEntityTableAdapter adapter;

  /// Creates a new [CreateYardLogsReservationsWhisper] instance.
  const CreateYardLogsReservationsWhisper({
    super.key,
    required this.adapter,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final CreateEntityFormController creationController = CreateEntityFormController();
    return Whisper(
      title: 'Create YardLog(s)',
      onPerform: () {
        creationController.create();
      },
      child:
          (_) => _CreateYardLogsReservationsWhisperContent(
            controller: creationController,
            adapter: adapter,
          ),
    );
  }
}
