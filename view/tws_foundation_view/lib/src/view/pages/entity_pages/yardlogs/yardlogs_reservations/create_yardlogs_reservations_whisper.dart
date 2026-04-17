
import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/pages/entity_pages/yardlogs/create_whisper/create_yardlogs_whisper.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_whisper_content.dart';

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
