
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_finder_selector.dart/entity_rich_finder_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/image_viewer.dart';
import 'package:tws_foundation_view/src/view/widgets/options_selector.dart';
import 'package:tws_foundation_view/src/view/widgets/photo_taker/icon_photo_taker.dart';
import 'package:tws_foundation_view/src/view/widgets/section_widget.dart';
import 'package:tws_foundation_view/src/view/widgets/selectable_list/selectable_list.dart';
import 'package:tws_foundation_view/src/view/widgets/whisper.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

part '_whisper_content.dart';
part '_whisper_truck_section.dart';
part '_whisper_driver_section.dart';
part '_whisper_trailer_section.dart';
part 'yardlog_whisper_form_designer.dart';

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
final class CreateYardLogsWhisper extends ViewPageBase {

  /// Creates a new [CreateYardLogsWhisper] instance.
  const CreateYardLogsWhisper({
    super.key,
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
          (_) => _CreateYardLogsWhisperContent(
            controller: creationController,
          ),
    );
  }
}
